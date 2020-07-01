import 'package:flutter/material.dart';

import 'Badge.dart';

class BadgeInfoPage extends StatelessWidget {

  static bool _obtained;
  static String _badgeName;
  static int _badgeID;

  //Constructor
  BadgeInfoPage(Badge B){
    _obtained = B.isObtained;
    _badgeName = B.name;
    _badgeID = B.badgeID;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_badgeName), //TODO: Design UI
      ),
    );
  }
}
