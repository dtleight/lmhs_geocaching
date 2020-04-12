import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/PageContainer.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PageContainer());
  }
}