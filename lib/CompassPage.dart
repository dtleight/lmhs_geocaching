import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_compass/flutter_compass.dart';

import 'Cache.dart';
class CompassPage extends StatelessWidget
{
  LatLng _targetLoc;

  CompassPage(Cache c) {
    GeoPoint gp = c.location;
    _targetLoc = LatLng(gp.latitude, gp.longitude);
  }

  @override
  Widget build(BuildContext context)
  {


    //title: 'Flutter Compass Demo',//theme: ThemeData(brightness: Brightness.dark),//darkTheme: ThemeData.dark(),
    return new Scaffold(
        appBar: AppBar(title: Text('Cache Name')),
        backgroundColor: Colors.black,
        body: Compass(targetLoc: _targetLoc,)
    );
  }
}


class Compass extends StatefulWidget
{
  LatLng targetLoc;

  Compass({Key key, this.targetLoc}) : super(key: key);
  @override
  _CompassState createState() => _CompassState(targetLoc);
}

class _CompassState extends State<Compass>
{
  LatLng _targetLoc;
  double _heading;

  _CompassState(LatLng t) {
    _targetLoc = t;
    _heading = 0;
  }

  String get _readout => _heading.toStringAsFixed(0) + '°';
  @override
  void initState()
  {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  void _onData(double x) => setState(() { _heading = x; });

  final TextStyle _style = TextStyle(
    color: Colors.red[50].withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
        foregroundPainter: CompassPainter(angle: _heading, targetLoc: _targetLoc),
        child: Center(child: Text(_readout, style: _style))
    );
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({ @required this.angle, this.targetLoc }) : super();

  LatLng targetLoc;
  double angle;
  bool loading = false;
  //gets orientation of angle
  double get rotation => -2 * pi * (angle / 360);

  Paint get _brush =>
      new Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush
      ..color = Colors.indigo[400].withOpacity(0.6);

    Paint needle = _brush
      ..color = Colors.red[400];

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    //Location of needle points
    Offset start = Offset.lerp(Offset(center.dx, radius), center, .4);
    Offset end = Offset.lerp(Offset(center.dx, radius), center, 0.1);

    getAngle();

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if(!loading) {
      print("Angle::");
      loading = true;
      getAngle();
    }
    return true;
  }

  Future<void> getAngle() async {
    print('Angle:: getAngle()');
    Geodesy geodesy = Geodesy();

    await Geolocator().checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Angle:: $position; $targetLoc');
    LatLng userLatLng = LatLng(position.latitude, position.longitude);

    angle = geodesy.bearingBetweenTwoGeoPoints(userLatLng, targetLoc);
    print('Angle:: $angle');
    await for
  }
}

/**
class Compass extends StatefulWidget
{
  GeoPoint destination;
  GeoPoint currLoc;
  double distance;
  double needleHeading;
  Compass(GeoPoint destination, GeoPoint currLoc)
  {
    this.destination = destination;
    this.currLoc = currLoc;
    needleHeading = atan((destination.longitude-currLoc.longitude)/(destination.latitude-currLoc.latitude));
  }
}

class CompassState extends State<Compass> {
  double _direction;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
      });
    });
  }
  ///trig
  ///Device orientation = _direction
  ///Angle from orientation to destination
  ///arctan(x/y)

  @override
  Widget build(BuildContext context) {
    //Needle
    //atan()
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Flutter Compass'),
        ),
        body: new Container(
          alignment: Alignment.center,
          color: Colors.white,
          //If no direction found, use 0, else use direction
          child: new Transform.rotate(
            angle: ((_direction ?? 0) * (pi / 180) * -1),
            child: new Image.asset('assets/compass.jpg'),
          ),
        ),
      ),
    );
  }
}
    **/