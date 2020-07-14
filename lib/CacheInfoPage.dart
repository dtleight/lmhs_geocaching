import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'CacheContainer.dart';
import 'Cache.dart';

class CacheInfoPage extends StatelessWidget
{
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  } // _onMapCreated

  static String _cacheName;
  static GeoPoint _cacheLoc;
  static int _cacheID;
  Cache c;
  CacheInfoPage(Cache cache)
  {
    this.c = cache;
    _cacheName = c.name;
    _cacheLoc = c.location;
    _cacheID = c.cacheID;
  } // CacheInfoPage Constructor

  @override
  Widget build(BuildContext context)
  {
    String _cacheLat = _cacheLoc.latitude.toString();
    String _cacheLng = _cacheLoc.longitude.toString();
    LatLng _cacheLatLng = new LatLng(_cacheLoc.latitude, _cacheLoc.longitude);

    return new Scaffold(
        appBar: AppBar
          (
            title: Text(_cacheName + " Information"),
            actions: <Widget>[IconButton( icon: Icon(Icons.my_location), onPressed: () { Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheContainer(c))); },),],
          ),
        body: ListView(
          children: <Widget>[
            Text(
              "Location: " + _cacheName + "\nLat: " + _cacheLat + " Long: " + _cacheLng,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 300,
              child: GoogleMap( //Map seems to take a long time to load in on my phone - Matt
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _cacheLatLng,
                  zoom: 15.0,
                ),
              ),
            ),
            // History
            Text(
              "History",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("This is an explanation of the historical significance of the location of Cache #1."),
            // Instructions
            Text(
              "Instructions",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("These are the instructions to find Cache #1."),
            // Comments
            Text(
              "Comments",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Card(
              child:
              Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text("This is one possible format for comments."),
                  ]
              ),
            ),
            Card(
              child:
              Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text("Here are two more,"),
                  ]
              ),
            ),
            Card(
              child:
              Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    Text("so this can scroll."),
                  ]
              ),
            ),
          ],
        )
    );
  }
}// CacheInfoPage Class