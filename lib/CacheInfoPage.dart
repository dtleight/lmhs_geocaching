import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'CacheContainer.dart';

class CacheInfoPage extends StatelessWidget {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final String _cacheName = "Cache #1";
  final String _cacheLoc = "Emmaus High School";
  final LatLng _cacheLatLng = const LatLng(40.533940, -75.506032);

  @override
  Widget build(BuildContext context) {
    List<String> _cacheLatLngList = _cacheLatLng.toString().split(",");
    String _cacheLat = _cacheLatLngList[0].substring(7, _cacheLatLngList[0].length);
    String _cacheLng = _cacheLatLngList[1].substring(0, _cacheLatLngList[1].length - 1);

    return new Scaffold(
        appBar: AppBar
          (
            title: Text(_cacheName + " Information"),
            actions: <Widget>[IconButton( icon: Icon(Icons.my_location), onPressed: () { Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheContainer())); },),],
          ),
        body: ListView(
          children: <Widget>[
            Text(
              "Location: " + _cacheLoc + "\nLat: " + _cacheLat + " Long: " + _cacheLng,
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
}