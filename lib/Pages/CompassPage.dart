import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_compass/flutter_compass.dart';

import '../Objects/Cache.dart';

class CompassPage extends StatelessWidget {
  final LatLng _targetLoc;

  CompassPage(Cache c)
      : _targetLoc = LatLng(c.location.latitude, c.location.longitude);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Compass(_targetLoc),
    );
  }
}

class Compass extends StatefulWidget {
  final LatLng targetLoc;

  Compass(this.targetLoc);

  @override
  CompassState createState() => CompassState();
}

class CompassState extends State<Compass> {
  LatLng? _userLoc;
  double _dist = 0;
  double _heading = 0;
  double _north = 0;
  double _angleAdjust = 0;
  bool _loading = false;

  String get _readout {
    if (_userLoc != null) {
      if (_dist < 100) {
        return "Nearby";
      } else if (_dist < 5280) {
        return _dist.toStringAsFixed(0) + " ft";
      } else {
        return (_dist / 5280 /*Feet to miles*/).toStringAsFixed(1) + " mi";
      }
    } else {
      return "Loading...";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLoc();
    FlutterCompass.events!.listen(_onData);
  }

  void _onData(CompassEvent event) {
    double? x = event.heading;

    if (mounted) {
      setState(() {
        if (_userLoc != null && x != null) {
          _heading = x - _angleAdjust;
          _north = x;

          if (!_loading) {
            _loading = true;
            getUserLoc();
          }
        }
      });
    }
  }

  Future<void> getUserLoc() async {
    print('Angle:: getAngle()');

    Geolocator.getCurrentPosition().then((position) {
      // newLoc is created here, so we can guarantee null safety.
      // Even though we know we're setting _userLoc to a non-null value, it
      // could still be set to null somewhere else because it is used in an
      // asynchronous context, meaning it could be made null by another thread
      // during the execution of this one.
      LatLng newLoc = LatLng(position.latitude, position.longitude);
      _userLoc = newLoc;

      _angleAdjust = Geodesy().bearingBetweenTwoGeoPoints(newLoc, widget.targetLoc) as double;
      // Overrides the green needle to point north if the user is less than 100 feet away
      if (Geodesy().distanceBetweenTwoGeoPoints(newLoc, widget.targetLoc) <
          30.48 /*100 ft in meters*/) {
        _angleAdjust = 0;
      }
      _dist = Geodesy().distanceBetweenTwoGeoPoints(newLoc, widget.targetLoc) *
          3.28084 /*Meters to feet*/;

      _loading = false;
    });
  }

  final TextStyle _style = TextStyle(
    color: Colors.green.shade400.withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter:
            CompassPainter(angle: _north, needleColor: Colors.red.shade400),
        child: CustomPaint(
            foregroundPainter:
                CompassPainter(angle: _heading, needleColor: Colors.green.shade400),
            child: Center(child: Text(_readout, style: _style))));
  }
}

class CompassPainter extends CustomPainter {
  CompassPainter({required this.angle, required this.needleColor}) : super();

  double angle;
  Color needleColor;

  //gets orientation of angle
  double get rotation => -2 * pi * (angle / 360);

  Paint get _brush => new Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush..color = Colors.indigo.shade400.withOpacity(0.6);

    Paint needle = _brush..color = needleColor;

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    // Location of needle points
    // Offset.lerp only returns null when a and b are both null, which never
    // happens here
    Offset start = Offset.lerp(center, Offset(center.dx, radius), .6)!;
    Offset end = Offset.lerp(center, Offset(center.dx, radius), 1)!;

    //// Debug output
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
