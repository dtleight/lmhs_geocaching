import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:lmhsgeocaching/CompassPage.dart';
import 'package:lmhsgeocaching/PageContainer.dart';

import 'Cache.dart';

void main() {
  //Flutter's app loader, instantiates a copy of the app.  Implicitly calls MyApp.build().
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LMHS Geocaching',
        home: CompassPage(Cache("Bob", 0, GeoPoint(40, -70)))/*Scaffold(40.553537, -75.570601
            appBar: AppBar(
              title: Text('LMHS Geocaching'),
              backgroundColor: Colors.blueGrey,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () => null,
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text('Login with Google'),
                  ),
                  MaterialButton(
                    onPressed: () => null,
                    color: Colors.red,
                    textColor: Colors.black,
                    child: Text('Logout'),
                  ),
                ],
              ),
            )
        )
        */
    );
  }
}