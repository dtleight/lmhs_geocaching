
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Objects/Cache.dart';
import '../Objects/Badge.dart';
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
  Map<int,Cache> iCaches;
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
  void init() async
  {
    await loadCaches();
    await loadBadges();
    await loadCollections();
  }
  Future<QuerySnapshot> loadDatabase(String collection) async
  {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return await ref.get();
  }
/**
  List<Cache> getCaches()
  {
    return caches;
  }
**/

  loadCaches() async
  {
    markers = Set();
    caches = [];
    iCaches = {};
    CollectionReference ref = FirebaseFirestore.instance.collection('caches');
    Reference sref = FirebaseStorage.instance.ref();
    QuerySnapshot eventsQuery = await ref.get();
    eventsQuery.docs.forEach((document) {
      GeoPoint gp = document['location'];
      Cache temp = new Cache.withMarker(document.id, document['cacheID'], document['completionCode'], document['description'],document['location'], new LatLng(gp.latitude, gp.longitude), new MarkerId(document.id));
      caches.add(temp);
      iCaches[document['cacheID']] = temp;
      markers.add(temp.mapMarker);
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
    //Parses a JSON-formatted String and returns a wrapper class for a list of Badge objects
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

  Future<String> loadPicture() async
  {
   String image = await FirebaseStorage.instance.ref().child('mill.jpg').getDownloadURL();
   return image;
  }
  ///
  /// Saves data to account - Needs to be changed
  ///
  updateAccount(Account a) async
  {
    await FirebaseFirestore.instance.collection('users').doc(a.email).update(
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

  void writeToCaches() async
  {
    for(Cache cache in this.caches)
    {

      await FirebaseFirestore.instance.collection('caches').doc(cache.name).update({'description': ""});
    }
  }

  void writeCompletionCodes() async
  {
      for(Cache cache in this.caches)
      {
      String s = generateRandomQrCode();
      print(s);
      await FirebaseFirestore.instance.collection('caches').doc(cache.name).update({'completionCode': generateRandomQrCode()});
      }
  }
  List<String> alreadyUsed = [];

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