import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cache
{
  String name;
  String completionCode;
  int cacheID;
  GeoPoint location;
  DateTime foundDate;
  Marker mapMarker;

  Cache(String name, int cacheID, GeoPoint location)
  {
    this.name = name;
    this.cacheID = cacheID;
    this.location = location;
    //this.completionCode = completionCode;
  }
  Cache.withMarker(String name, int cacheID, String completionCode, GeoPoint location, LatLng position, MarkerId markerId)
  {
    this.name = name;
    this.cacheID = cacheID;
    this.completionCode = completionCode;
    this.location = location;
    this.mapMarker = new Marker(position: position, markerId: markerId);
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