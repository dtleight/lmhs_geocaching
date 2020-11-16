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
    double infoBoxPos = -100;
    return Scaffold(
      appBar: AppBar(title: Text("LMTHS Geocaching"), actions: <Widget>[
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
            )),
      ]),
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
      body: Stack(
        children: <Widget>[
          FutureBuilder(
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
          /*** This is the beginning of a concept Matt had where an info popup would come up when you tapped on a marker on the map
           * Based on: https://medium.com/flutter-community/add-a-custom-info-window-to-your-google-map-pins-in-flutter-2e96fdca211a
           * Would allow the user to go to the CacheInfoPage from this page
          AnimatedPositioned(
            bottom: infoBoxPos,
            right: 0,
            left: 0,
            duration: Duration(milliseconds: 200),
            child: Align(
                alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 29,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(.5)
                    ),
                  ],
                ),
              ),
            ),
          ),***/
        ],
      ),
    );
  }
}
