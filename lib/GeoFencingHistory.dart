import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'DatabaseRouting.dart';

class HomePage extends StatefulWidget
{
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
  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    new DatabaseRouting().init();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _getLocation() async {
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      setState(() {});
    } on Exception {
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder
        (
        future:  new DatabaseRouting().loadCaches(),
        builder: (context,snapshot)
        {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');

            default:
              return GoogleMap
                (
                onMapCreated: _onMapCreated,
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition
                  (
                  target: _pos,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                markers: new DatabaseRouting().markers,
              );
          }
        },
      ),
    );
  }
}