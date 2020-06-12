import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Badge.dart';

class BadgeDisplayPage extends StatelessWidget {

  List badgeList;

  @override
  Widget build(BuildContext context) {
    badgeList = [new Badge("one"), new Badge("two"), new Badge("three")];

    return new Scaffold(
      GridView.builder(itemBuilder: (context, position) {
        return Card(
          child: ,
        )
      },
      )
    );
  }
}
