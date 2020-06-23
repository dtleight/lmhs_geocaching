import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'ProfilePage.dart';
import 'BadgeDisplayPage.dart';
import 'SettingsPage.dart';
import 'AboutPage.dart';

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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Luigi"),
                accountEmail: Text("luigi.green@gmail.com"),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://vignette.wikia.nocookie.net/nintendo/images/0/04/New_Super_Mario_Bros._U_Deluxe_-_Luigi_01.png/revision/latest?cb=20181226204244&path-prefix=en"),
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://vignette.wikia.nocookie.net/nintendo/images/d/d8/New_Super_Mario_Bros._U_Deluxe_-_Mario_01.png/revision/latest?cb=20181226204245&path-prefix=en"),
                    ),
                  ),
                ],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://i.pinimg.com/originals/dc/8d/ef/dc8def609c27f9123c4f61a83a3b93bd.jpg")
                  )
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new ProfilePage()));} ,
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text('Badges'),
                onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeDisplayPage()));} ,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new SettingsPage()));} ,
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('About'),
                onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new AboutPage()));} ,
              )
            ],
          ),
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