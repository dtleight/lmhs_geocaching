import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Containers/CacheTrackingContainer.dart';
import '../Objects/Cache.dart';

class CacheInfoPage extends StatelessWidget {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  } // _onMapCreated

  static String _cacheName;
  static GeoPoint _cacheLoc;
  static int _cacheID;
  Cache c;

  CacheInfoPage(Cache cache) {
    this.c = cache;
    _cacheName = c.name;
    _cacheLoc = c.location;
    _cacheID = c.cacheID;
  } // CacheInfoPage Constructor

  @override
  Widget build(BuildContext context) {
    String _cacheLat = _cacheLoc.latitude.toString();
    String _cacheLng = _cacheLoc.longitude.toString();
    LatLng _cacheLatLng = new LatLng(_cacheLoc.latitude, _cacheLoc.longitude);

    return new Scaffold(
        appBar: AppBar(
          title: Text(_cacheName + " Information"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctxt) => new CacheContainer(c)));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child:
              Text(
                "Location: " +
                    _cacheName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _cacheLatLng,
                  zoom: 15.0,
                ),
              ),
            ),
            // History
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "History",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              //todo: I commented out this variable to replace it with text for showcase purposes. Swap back later
              child: //Text(c.description),
              Text('Here is the history of the place.'),
              // Instructions
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child:
                  //todo the text description for how to find the cash should also be a variable
                  Text("These are the instructions to find Cache #1."),
            ),
            /*Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )

                // Comments

                ),
            Card(
              child: Row(children: <Widget>[
                Icon(Icons.person),
                Text("This is one possible format for comments."),
              ]),
            ),
            Card(
              child: Row(children: <Widget>[
                Icon(Icons.person),
                Text("Here are two more,"),
              ]),
            ),
            Card(
              child: Row(children: <Widget>[
                Icon(Icons.person),
                Text("so this can scroll."),
              ]),
            ),*/
          ],
        ) );
  }
} // CacheInfoPage Class
