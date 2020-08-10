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
  String _cacheName;

  CompassPage(Cache c) {
    GeoPoint gp = c.location;
    _targetLoc = LatLng(gp.latitude, gp.longitude);
  }

  @override
  Widget build(BuildContext context)
  {
    //title: 'Flutter Compass Demo',//theme: ThemeData(brightness: Brightness.dark),//darkTheme: ThemeData.dark(),
    return new Scaffold(
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
  LatLng _userLoc;
  double _heading = 0;
  double _north = 0;
  double _angleAdjust;
  bool _loading = false;

  _CompassState(LatLng t) {
    _targetLoc = t;
    getUserLoc();
  }

  String get _readout {
    if(_userLoc != null) {
      double dist = Geodesy().distanceBetweenTwoGeoPoints(_userLoc, _targetLoc) * 3.28084 /*Meters to feet*/;
      if(dist < 5280) {
        return dist.toStringAsFixed(0) + " ft";
      } else {
        return (dist / 5280 /*Feet to miles*/).toStringAsFixed(1) + " mi";
      }
    } else {
      return "Loading...";
    }
  }

  @override
  void initState()
  {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  void _onData(double x) {
    if(mounted) {
      setState(() {
        if (_userLoc != null) {
          _angleAdjust = Geodesy().bearingBetweenTwoGeoPoints(_userLoc, _targetLoc);
          _heading = x - _angleAdjust;
          _north = x;

          if (!_loading) {
            //print("loading: $_loading");
            _loading = true;
            //print('loading2: $_loading');
            getUserLoc();
          }
        }
      });
    }
  }

  Future<void> getUserLoc() async {
    print('Angle:: getAngle()');
    //print('loading3: $_loading');

    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
          _userLoc = LatLng(position.latitude, position.longitude);
          _loading = false;
          //print('loading4: $_loading');
    });
  }

  final TextStyle _style = TextStyle(
    color: Colors.green[400].withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
        foregroundPainter: CompassPainter(angle: _north, needleColor: Colors.red[400]),
        child: CustomPaint(
            foregroundPainter: CompassPainter(angle: _heading, needleColor: Colors.green[400]),
            child: Center(child: Text(_readout, style: _style))
        )
    );
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({ @required this.angle, @required this.needleColor }) : super();

  double angle;
  Color needleColor;
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
      ..color = needleColor;

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    //Location of needle points
    Offset start = Offset.lerp(center, Offset(center.dx, radius), .6);
    Offset end = Offset.lerp(center, Offset(center.dx, radius), 1);


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
}