import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Pages/CacheInfoPage.dart';

class Cache {
  String name;
  int cacheID;
  String completionCode;
  GeoPoint location;
  DateTime? foundDate;
  String imgSRC;
  String description;
  String instructions;
  String hint;

  Cache(
    this.name,
    this.cacheID,
    this.completionCode,
    this.location,
    this.imgSRC,
    this.description,
    this.instructions,
    this.hint,
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
          : InfoWindow.noText,
    );
  }

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void onCacheFound() {
    //updateBadges();
  }
}
