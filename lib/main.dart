import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'LoginPage.dart';

void main() => runApp(Phoenix(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      //PageContainer()
    );
  }
}
