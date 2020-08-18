
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Objects/Cache.dart';
import '../Objects/Badge.dart';
import '../Pages/CacheInfoPage.dart';
import '../Objects/Collection.dart';
import 'Account.dart';
import '../Utilities/BadgeLoader.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import '../Utilities/Collections.dart';

class DatabaseRouting
{
  static final DatabaseRouting _db = DatabaseRouting._internal();

  List<Cache> caches;
  Set<Marker> markers;
  List<Badge> badges;
  List<Collection> collections;
  BuildContext context;

  factory DatabaseRouting()
  {
    return _db;
  }

  DatabaseRouting._internal();
  void init()
  {
    loadCaches();
    loadBadges();
  }
  Future<QuerySnapshot> loadDatabase(String collection) async
  {
    CollectionReference ref = Firestore.instance.collection(collection);
    return await ref.getDocuments();
  }
/**
  List<Cache> getCaches()
  {
    return caches;
  }
**/

  void createUser(Account account)
  {
    print("Database write started");
    Firestore.instance.collection("users").document(account.email).setData(
        {
          'joinDate': account.joinDate,
          'cachesCompleted': account.cacheCompletions,
          'badgesCompleted': account.badgeCompletions,
        }

    );
  }

  Future<void> generateUser(String name, String email, String imageSRC) async
  {
    DocumentSnapshot ds = await Firestore.instance.collection("users").document(email).get();
    if(ds.data != null)
      {
        List<dynamic> cCompletions = new List<dynamic>();
        List<dynamic> bCompletions = new List<dynamic>();
        cCompletions.addAll(ds.data['cachesCompleted']);
        bCompletions.addAll(ds.data['badgesCompleted']);
        Account a = new Account.fromDatabase(name, email, imageSRC, ds.data['joinDate'], cCompletions, bCompletions);
      }
    else
      {
        createUser(Account.instantiate(name, email, imageSRC, Timestamp.now()));
      }
  }

  //Updates a users data
  void updateUser() async
  {
    Firestore.instance.collection('users').document('customer1').updateData({'completionCode':'randomizedString'});

  }

  loadCaches() async
  {
    markers = Set();
    caches = new List();
    CollectionReference ref = Firestore.instance.collection('caches');
    QuerySnapshot eventsQuery = await ref.getDocuments();
    eventsQuery.documents.forEach((document) {
      GeoPoint gp = document['location'];
      Cache temp = new Cache.withMarker(document.documentID, document['cacheID'], document['completionCode'], document['location'], new LatLng(gp.latitude, gp.longitude), new MarkerId(document.documentID));
      caches.add(temp);
      markers.add(temp.mapMarker);
      /**
      markers.add(new Marker(
          position: new LatLng(gp.latitude, gp.longitude),
          markerId: new MarkerId(document.documentID),
          onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage(new Cache(document.documentID,document['cacheID'],gp))));}
      )
      );
          **/
    });
  }

  ///
  /// Loads JSON file from assets
  ///
  Future<String> _loadBadgeList() async
  {
    return await rootBundle.loadString('badge-images/badge_data.json');
  }

  ///
  /// Retrieves list data from JSON file
  ///
   loadBadges() async
   {
    String jsonString = await _loadBadgeList();
    final jsonResponse = json.decode(jsonString);
    BadgeLoader bl = new BadgeLoader.fromJson(jsonResponse);
    badges = bl.badges;
  }

  ///
  /// Loads JSON file from assets
  ///
  Future<String> _loadCollections() async
  {
    return await rootBundle.loadString('badge-images/collection_data.json');
  }

  ///
  /// Retrieves list data from JSON file
  ///
  loadCollections() async
  {
    String jsonString = await _loadCollections();
    final jsonResponse = json.decode(jsonString);
    Collections cl = new Collections.fromJson(jsonResponse);
    collections = cl.collections;
  }
  ///
  /// Saves data to account
  ///
  updateAccount(Account a) async
  {
    await Firestore.instance.collection('users').document(a.email).updateData(
        {
          'cachesCompleted': a.cacheCompletions,
          'badgesCompleted': a.badgeCompletions
        }
        );
}

  //Temporary Methods

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/qrcodes.txt');
  }

  Future<File> write(String qrcode) async
  {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString(qrcode);
  }

  void writeCompletionCodes() async
  {
      for(Cache cache in this.caches)
      {
      String s = generateRandomQrCode();
      print(s);
      await Firestore.instance.collection('caches').document(cache.name).updateData({'completionCode': generateRandomQrCode()});
      }
  }
  List<String> alreadyUsed = new List<String>();

   String generateRandomQrCode()
  {
    String alphanum = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    String randomString = '';
    for(int i = 0; i < 4; i++)
      {
        int randNumber = new Random().nextInt(alphanum.length);
        randomString += alphanum.substring(randNumber,randNumber+1);
      }
    if(!alreadyUsed.contains(randomString))
      {
        alreadyUsed.add(randomString);
        return 'LMHSGEO-' + randomString;
      }
    else
      {
        return generateRandomQrCode();
      }
      }
      }