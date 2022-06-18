import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Pages/CacheInfoPage.dart';

class Cache {
  String name;
  String completionCode;
  int cacheID;
  GeoPoint location;
  DateTime foundDate;
  String imgSRC;
  String description;
  String instructions;

  Cache(this.name, this.cacheID, this.location /*,this.completionCode*/);

  Cache.withMarker(
    this.name,
    this.cacheID,
    this.completionCode,
    this.description,
    this.location,
    this.imgSRC,
    this.instructions,
  );

  Marker buildMarker(BuildContext context, {bool enableInfoWindow = true}) {
    LatLng position = LatLng(this.location.latitude, this.location.longitude);

    return Marker(
      position: position,
      markerId: MarkerId(this.name),
      infoWindow: enableInfoWindow
          ? InfoWindow(
              title: this.name,
              snippet: position.longitude.toString() +
                  ", " +
                  position.latitude.toString(),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (ctxt) => new CacheInfoPage(this)),
                );
              },
            )
          : null,
    );
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges();
  }
}
