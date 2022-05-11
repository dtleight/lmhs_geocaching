import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmhsgeocaching/Widgets/UserDrawer.dart';
import 'package:location/location.dart';
import '../Pages/CachePage.dart';
import '../Singletons/DatabaseRouting.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LMHS Geocaching"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new CachePage()));
              },
              child: Icon(
                Icons.grid_on,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      drawer: UserDrawer(),
      body: FutureBuilder(
        future: new DatabaseRouting().loadCaches(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: _pos,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                markers: buildMarkers(
                  new DatabaseRouting().markerBuildFunctions,
                  context,
                ),
              );
          }
        },
      ),
    );
  }

  Set<Marker> buildMarkers(
    Set<Marker Function(BuildContext context)> buildFunctions,
    BuildContext context,
  ) {
    Set<Marker> markers = Set();
    for (Marker Function(BuildContext context) build in buildFunctions) {
      markers.add(build(context));
    }

    return markers;
  }
}
