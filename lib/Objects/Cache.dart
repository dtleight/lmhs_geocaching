import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cache {
  String name;
  String completionCode;
  int cacheID;
  GeoPoint location;
  DateTime foundDate;
  Marker mapMarker;
  String imgSRC;
  String description;

  Cache(String name, int cacheID, GeoPoint location) {
    this.name = name;
    this.cacheID = cacheID;
    this.location = location;
    //this.completionCode = completionCode;
  }

  Cache.withMarker(String name, int cacheID, String completionCode,String description,
      GeoPoint location, LatLng position, MarkerId markerId) {
    print(description);
    this.name = name;
    this.cacheID = cacheID;
    this.completionCode = completionCode;
    this.location = location;
    this.description = description;
    this.mapMarker = new Marker(position: position, markerId: markerId);
  }

  ///Allows for forward referencing of marker
  void setMarker(Marker marker) {
    this.mapMarker = mapMarker;
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges();
  }

  String getImgSRC() {
    if(imgSRC != null) {
      return imgSRC;
    } else {
      return "badge-images/barn.jpg";
    }
  }
}
