import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Singletons/Account.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ProfilePage.dart';
import 'BadgeDisplayPage.dart';
import 'SettingsPage.dart';
import 'AboutPage.dart';
import '../Objects/Cache.dart';
import 'CacheInfoPage.dart';
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
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(new Account().name),
              accountEmail: Text(new Account().email),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(new Account().imageSrc),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/dc/8d/ef/dc8def609c27f9123c4f61a83a3b93bd.jpg"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctxt) => new ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text('Badges'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctxt) => new BadgeDisplayPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (ctxt) => new SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('About'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new AboutPage()));
              },
            )
          ],
        ),
      ),
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
                markers: new DatabaseRouting().markers,
              );
          }
        },
      ),
    );
  }
}
