import 'package:flutter/material.dart';

import 'Badge.dart';

class BadgeInfoPage extends StatelessWidget {

  Badge _badge; // Badge to be described on this page

  //Constructor
  BadgeInfoPage(Badge badge){
    _badge = badge;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_badge.getName()),
      ),
    );
  }
}
