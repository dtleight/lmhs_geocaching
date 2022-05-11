import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmhsgeocaching/Pages/CacheTrackerPage.dart';
import 'package:lmhsgeocaching/Utilities/ColorTheme.dart';
import 'package:lmhsgeocaching/Widgets/InfoSelector.dart';
import '../Objects/Cache.dart';

class CacheInfoPage extends StatelessWidget {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  } // _onMapCreated

  static String _cacheName;
  static GeoPoint _cacheLoc;
  Cache cache;

  CacheInfoPage(this.cache) {
    _cacheName = cache.name;
    _cacheLoc = cache.location;
  } // CacheInfoPage Constructor

  @override
  Widget build(BuildContext context) {
    LatLng _cacheLatLng = new LatLng(_cacheLoc.latitude, _cacheLoc.longitude);

    return new Scaffold(
      appBar: AppBar(
        title: Text("Cache Information"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigation_sharp),
            onPressed: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (ctxt) => new CacheTrackerPage(cache),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorTheme.backgroundColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _cacheLatLng,
                zoom: 15.0,
              ),
              markers: {
                this.cache.buildMarker(context, enableInfoWindow: false)
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              _cacheName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorTheme.textColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: InfoSelector(cache),
          )
        ],
      ),
    );
  }
} // CacheInfoPage Class
