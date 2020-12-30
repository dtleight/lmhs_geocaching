import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Objects/Badge.dart';
import '../Utilities/ColorTheme.dart';

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
  BadgeInfoPage(Badge B) {
    _obtained = B.isObtained;
    _badgeName = B.name;
    _badgeID = B.badgeID;
    badgeImage = B.decideFilter(Image.asset(B.imageSRC));
    _unlockDate = B.unlockDate;
    description = B.description;
    progress = B.getProgress();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Badge Info"),
      ),
      backgroundColor: ColorTheme.backgroundColor,
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
          child: Text(
            _badgeName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorTheme.textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity, // Fits the width of the screen
          height: 250,
          child: badgeImage,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorTheme.textColor,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Text(
            "Badge Progress",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorTheme.textColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 20,
                valueColor: AlwaysStoppedAnimation(Colors.red[600]),
                backgroundColor: ColorTheme.textColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Text(
            _obtained
                ? "You earned this badge on: " + _unlockDate.toString()
                : "You have not earned this badge.",
            style: TextStyle(
              color: ColorTheme.textColor,
              fontSize: 18,
            ),
          ),
        ),
      ]),
    );
  }
}
