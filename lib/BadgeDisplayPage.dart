import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lmhsgeocaching/BadgeInfoPage.dart';

import 'Badge.dart';
import 'Profile.dart';

class BadgeDisplayPage extends StatelessWidget {

  List<Badge> badgeList;

  @override
  Widget build(BuildContext context) {
    badgeList = Profile.badgeList;

    return new Scaffold(
      appBar: AppBar(
        title: Text("Badges"),
      ),

      body: GridView.builder(
        itemBuilder: (context, position) {
          return Card(
            child: FlatButton(
              child: Image.memory(badgeList[position].getImage()),
              shape: CircleBorder(
                side: BorderSide(
                  width: 10
                )
              ),
              onPressed: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badgeList[position])));},
            ),
          );
        },
        itemCount: badgeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      )
    );
  }
}
