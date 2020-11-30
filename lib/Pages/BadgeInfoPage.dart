import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Objects/Badge.dart';

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
    description = B.description;
    progress = B.getProgress();
  }

  @override
  Widget build(BuildContext context)
  {
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
            Text(_obtained? "You earned this badge on: " + _unlockDate.toString():"You have not earned this badge.",style: TextStyle(fontSize: 18),),
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
