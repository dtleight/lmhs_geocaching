import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_compass/flutter_compass.dart';

import 'Cache.dart';
class CompassPage extends StatelessWidget /// I don't know what to do with the immutable warning
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
  double _heading = 0;
  double _angleAdjust;
  bool _loading = false;

  _CompassState(LatLng t) {
    _targetLoc = t;
    getAngle();
  }

  String get _readout => (_heading % 360).toStringAsFixed(0) + '°';

  @override
  void initState()
  {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  void _onData(double x) => setState(() {
    if(_angleAdjust != null) {
      _heading = x - _angleAdjust;

      if(!_loading) {
        //print("loading: $_loading");
        _loading = true;
        //print('loading2: $_loading');
        getAngle();
      }
    } else {
      _heading = 0;
    }
  });

  Future<void> getAngle() async {
    print('Angle:: getAngle()');
    //print('loading3: $_loading');
    Geodesy geodesy = Geodesy();

    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      //print('Angle:: $position');
      LatLng userLatLng = LatLng(position.latitude, position.longitude);

      _angleAdjust = geodesy.bearingBetweenTwoGeoPoints(userLatLng, _targetLoc);
      //print('Angle:: $_angleAdjust');
      _loading = false;
      //print('loading4: $_loading');
    });
  }

  final TextStyle _style = TextStyle(
    color: Colors.red[50].withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
        foregroundPainter: CompassPainter(angle: _heading),
        child: Center(child: Text(_readout, style: _style))
    );
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({ @required this.angle }) : super();

  double angle;
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


    //print('ang: $angle');
    //print('rot: $rotation; ' + (-2 * pi * (angle / 360)).toString());

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

    /*
    position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Angle:: $position; $targetLoc');
    LatLng userLatLng = LatLng(position.latitude, position.longitude);

    angle = geodesy.bearingBetweenTwoGeoPoints(userLatLng, targetLoc);
    print('Angle:: $angle');
    if(position.latitude > 0) {
      loading = false;
    }
    */
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