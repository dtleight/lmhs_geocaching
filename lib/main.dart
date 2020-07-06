import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/PageContainer.dart';

void main()
{
  //Flutter's app loader, instantiates a copy of the app.  Implicitly calls MyApp.build().
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
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