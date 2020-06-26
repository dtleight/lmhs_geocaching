import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Badge.dart';

class Cache
{
  String name;
  int cacheID;
  GeoPoint location;
  bool found;


  //List<Badge> _badgeCompletionList;

  Cache(String name, int cacheID, GeoPoint location)
  {
    this.name = name;
    this.cacheID = cacheID;
    this.location = location;
    this.found = false;
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges(this);
  }

}