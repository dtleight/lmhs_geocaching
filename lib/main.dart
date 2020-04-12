import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageViewDemo());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  LatLng _pos = const LatLng(40.523938, -75.547719);
  void loadPosition() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _pos = LatLng(position.latitude,position.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
        ));
  }
}

class CachePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #1'),
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage()));} ,
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #2'),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #3'),
          ),
        ],
      ),
    );
  }
}

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        MyHomePage(title: 'Lower Macungie Historical Society Geocaching'),
        CachePage(),
      ],
    );
  }
}

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
      appBar: AppBar(title: Text(_cacheName + " Information")),
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
            child: GoogleMap( //Map seems to take a long time to load in on my phone - Magee
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
