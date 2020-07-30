import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Cache.dart';
import 'Badge.dart';
import 'CacheInfoPage.dart';
import 'Account.dart';
import 'BadgeLoader.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DatabaseRouting
{
  static final DatabaseRouting _db = DatabaseRouting._internal();

  List<Cache> caches;
  Set<Marker> markers;
  List<Badge> badges;
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

  List<Cache> getCaches()
  {
    return caches;
  }

  //Writes to each element
  /**
   *
  void createUser() async
  {
    QuerySnapshot querySnapshot = await loadDatabase('users');
    querySnapshot.documents.forEach((element)
    {
      element.reference.updateData({'uuid': "Random UUID"});
    }
    );
  }
**/
  void createUser(Account account)
  {
    Firestore.instance.collection('users').add(
        {
          'joinDate': account.joinDate,
          'cachesCompleted':account.cacheCompletions,
          'badgesCompleted':account.badgeCompletions,
        }
        );
  }
  //Creates a new user
  void createUser2() async
  {
    Firestore.instance.collection('users').add({'uuid':"Random", "caches_completed": 1});
  }
  //Updates a users data
  void updateUser() async
  {
    Firestore.instance.collection('users').document('customer1').updateData({'uuid':'RandomUUID'});
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
}