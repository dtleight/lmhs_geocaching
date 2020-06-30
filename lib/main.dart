import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/PageContainer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Cache.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: 'LMHS Geocaching',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageContainer());
  }
}