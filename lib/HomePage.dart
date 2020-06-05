import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  GoogleMapController mapController;
  LatLng _pos = const LatLng(40.523938, -75.547719);
  LocationData currentLocation;
  Location location;


  void _onMapCreated(GoogleMapController controller) async{
    mapController = controller;
  }
  void _getLocation() async {
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      setState(
              () {}); //rebuild the widget after getting the current location of the user
    } on Exception {
      currentLocation = null;
    }
  }
  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _pos,
            zoom: 15.0,
          ),
          myLocationEnabled: true,
        ));
  }
}