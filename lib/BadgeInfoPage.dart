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
  static Widget badgeImage;
  static DateTime _unlockDate;
  static String dateGot;
  static String description;
  static double progress;

  //Constructor
  BadgeInfoPage(Badge B){
    _obtained = B.isObtained;
    _badgeName = B.name;
    _badgeID = B.badgeID;
    badgeImage = B.decideFilter(Image.asset(B.imageSRC));
    _unlockDate = B.unlockDate;
    description = /*B.description*/ "This is where the descriptiion of what the user needs to do to earn this badge will be.";
    progress = .6;
  }

  @override
  Widget build(BuildContext context)
  {
    Text earnDateText;
    if(_obtained) {
      earnDateText = Text(
        "You earned this badge on: " + _unlockDate.toString(),
        style: TextStyle(
          fontSize: 18,
        ),
      );
    } else {
      earnDateText = Text(
        "You have not earned this badge.",
        style: TextStyle(
          fontSize: 18,
        ),
      );
    }
    return new Scaffold(
        appBar: AppBar (
            title: Text(_badgeName),
          ),
        body: ListView(
          children: <Widget>[
          SizedBox(
            width: double.infinity, // Fits the width of the screen
            height: 250,
            child: badgeImage,
          ),
            SizedBox(
              height: 20,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            earnDateText,
            SizedBox(
              height: 20,
            ),
            Text(
              "Badge Progress",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            LinearProgressIndicator(
              value: progress,
            ),
        ]),
    );
  }
}
