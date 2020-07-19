import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cache
{
  String name;
  int cacheID;
  GeoPoint location;
  bool found;
  DateTime foundDate;
  Marker mapMarker;

  Cache(String name, int cacheID, GeoPoint location)
  {
    this.name = name;
    this.cacheID = cacheID;
    this.location = location;
    this.found = false;
  }
  Cache.withMarker(String name, int cacheID, GeoPoint location, LatLng position, MarkerId markerId)
  {
    this.name = name;
    this.cacheID = cacheID;
    this.location = location;
    this.mapMarker = new Marker(position: position, markerId: markerId);
    this.found = false;
  }
  ///Allows for forward referencing of marker
  void setMarker(Marker marker)
  {
   this.mapMarker = mapMarker;
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges();
  }

}