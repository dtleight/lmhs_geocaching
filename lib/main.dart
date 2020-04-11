import 'dart:async';

import 'package:flutter/material.dart';
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

  final LatLng _center = const LatLng(40.523938, -75.547719);

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
            target: _center,
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
        CacheInfoPage(),
      ],
    );
  }
}

class CacheInfoPage extends StatelessWidget {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final LatLng _cacheLoc = const LatLng(40.533940, -75.506032);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Cache #1 Information")),
      body: ListView(
        children: <Widget>[
          Title(color: Colors.blue, child: Text("Cache #1")),
          Text("Location: Lat, Long"),
          SizedBox(
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _cacheLoc,
                zoom: 15.0,
              ),
            ),
          ),
          Title(color: Colors.blue, child: Text("History")),
          Text("This is an explanation of the historical significance of the location of Cache #1."),
          Title(color: Colors.blue, child: Text("Instructions")),
          Text("These are the instructions to find Cache #1."),
          Title(color: Colors.blue, child: Text("Comments")),
          Text("I have no idea how to format these."),
        ],
      )
    );
  }
}