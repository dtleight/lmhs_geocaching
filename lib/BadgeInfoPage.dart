import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'Badge.dart';
import 'BadgeLoader.dart';

class BadgeInfoPage extends StatelessWidget {


  static bool _obtained;
  static String _badgeName;
  static int _badgeID;
  static Image badgeImage;
  static DateTime _unlockDate;
  static String dateGot;
  static String description;

  //Constructor
  BadgeInfoPage(Badge B){
    _obtained = B.isObtained;
    _badgeName = B.name;
    _badgeID = B.badgeID;
    badgeImage = B.getImage();
    _unlockDate = B.unlockDate;
  }

  @override
  Widget build(BuildContext context)
  {
    dateGot= _unlockDate.toString();
    return new Scaffold(
        appBar: AppBar
          (
        title: Text(_badgeName),
          ),
        body: ListView(
          children: <Widget>[
          SizedBox(
          width: 800,
          height: 200,
          child: badgeImage,
          ),
          Text(
            "Congrats on earning the " + _badgeName + " badge!",
              style: TextStyle(
              fontSize: 18,
              ),
          ),
            SizedBox(
              height: 25,
            ),
            Text(
              "You earned this badge on: " + dateGot,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text("The badge's description will go here. Right under the description header."/*description*/),
        ]),
    );
  }
}
