import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmhsgeocaching/Pages/CacheTrackerPage.dart';
import 'package:lmhsgeocaching/Utilities/ColorTheme.dart';
import 'package:lmhsgeocaching/Widgets/InfoSelector.dart';
import '../Objects/Cache.dart';

class CacheInfoPage extends StatelessWidget {
  late final GoogleMapController mapController;
  final Cache cache;

  CacheInfoPage(this.cache);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  } // _onMapCreated

  @override
  Widget build(BuildContext context) {
    LatLng _cacheLatLng = new LatLng(
      cache.location.latitude,
      cache.location.longitude,
    );

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
              cache.name,
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
