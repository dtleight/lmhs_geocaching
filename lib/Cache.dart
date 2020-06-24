import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Badge.dart';

class Cache
{
  GeoPoint location;
  int cacheID;
  String name;

  //List<Badge> _badgeCompletionList;

  Cache(GeoPoint location, int cacheID, String name)
  {
    this.location = location;
    this.cacheID = cacheID;
    this.name = name;
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges(this);
  }

}