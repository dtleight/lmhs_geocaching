import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Cache.dart';
import 'Badge.dart';
import 'CacheInfoPage.dart';
import 'Collection.dart';
import 'Account.dart';
import 'BadgeLoader.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'Collections.dart';

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
        Account a = new Account.fromDatabase(name, email, imageSRC, ds.data['joinDate'], ds.data['cacheCompletions'], ds.data['badgeCompletions']);
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
      Cache temp = new Cache.withMarker(document.documentID, document['cacheID'], document['location'], new LatLng(gp.latitude, gp.longitude), new MarkerId(document.documentID));
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
}