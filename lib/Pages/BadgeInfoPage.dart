import 'package:flutter/material.dart';
import '../Objects/Badge.dart';
import '../Utilities/ColorTheme.dart';

class BadgeInfoPage extends StatelessWidget {
  final Badge badge;

  BadgeInfoPage(this.badge);

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
            badge.name,
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
          child: badge.decideFilter(Image.asset(badge.imageSRC)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
          child: Text(
            badge.description,
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
                value: badge.getProgress(),
                strokeWidth: 20,
                valueColor: AlwaysStoppedAnimation(Colors.red[600]),
                backgroundColor: ColorTheme.textColor,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
