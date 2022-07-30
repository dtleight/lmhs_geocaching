import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';

class Compass extends StatefulWidget {
  final LatLng _targetLoc;

  Compass(GeoPoint targetPoint)
      : _targetLoc = LatLng(
          targetPoint.latitude,
          targetPoint.longitude,
        );

  @override
  CompassState createState() => CompassState();
}

class CompassState extends State<Compass> {
  LatLng? _userLoc;
  double _heading = 0;
  double _north = 0;
  bool _loading = false;

  String get _readout {
    if (_userLoc != null) {
      double dist =
          Geodesy().distanceBetweenTwoGeoPoints(_userLoc!, widget._targetLoc) *
              3.28084 /*Meters to feet*/;
      if (dist < 100) {
        return "Nearby";
      } else if (dist < 5280) {
        return dist.toStringAsFixed(0) + " ft";
      } else {
        return (dist / 5280 /*Feet to miles*/).toStringAsFixed(1) + " mi";
      }
    } else {
      return "Loading...";
    }
  }

  Future<void> getUserLoc() async {
    print('Angle:: getAngle()');
    //print('loading3: $_loading');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _userLoc = LatLng(position.latitude, position.longitude);
    _loading = false;
    //print('loading4: $_loading');
  }

  final TextStyle _style = TextStyle(
    color: Colors.green.shade400.withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double? x = snapshot.data?.heading;

          if (_userLoc != null && x != null) {
            double _angleAdjust =
            Geodesy().bearingBetweenTwoGeoPoints(_userLoc!, widget._targetLoc)
            as double;
            // Overrides the green needle to point north if the user is less than 100 feet away
            if (Geodesy()
                .distanceBetweenTwoGeoPoints(_userLoc!, widget._targetLoc) <
                30.48 /*100 ft in meters*/) {
              _angleAdjust = 0;
            }
            _heading = x - _angleAdjust;
            _north = x;
          }
          if (!_loading) {
            //print("loading: $_loading");
            _loading = true;
            //print('loading2: $_loading');
            getUserLoc();
          }
        }


        return CustomPaint(
          foregroundPainter: CompassPainter(
            angle: _north,
            needleColor: Colors.red.shade400,
          ),
          child: CustomPaint(
            foregroundPainter: CompassPainter(
              angle: _heading,
              needleColor: Colors.green.shade400,
            ),
            child: Center(child: Text(_readout, style: _style)),
          ),
        );
      },
    );
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
    ..strokeWidth = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = _brush..color = Colors.red.withOpacity(0.6);

    Paint needle = _brush..color = needleColor;

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    //Location of needle points
    // Offset.lerp only returns null when a and b are both null, which never
    // happens here
    Offset start = Offset.lerp(center, Offset(center.dx, radius), .6)!;
    Offset end = Offset.lerp(center, Offset(center.dx, radius), 1)!;

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
