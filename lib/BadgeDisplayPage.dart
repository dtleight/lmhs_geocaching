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



    return new Scaffold (
      appBar: AppBar(
        title: Text("Badges"),
      ),

      body: GridView.builder(
        itemBuilder: (context, position) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
              InkWell(
              child: CircleAvatar(
                backgroundColor: Color(0xffFDCF09),
                radius:90,
                child: CircleAvatar(backgroundImage: AssetImage(badgeList[position].getSRC()),radius: 85,)),
            onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badgeList[position])));},
              ),
                Text(badgeList[position].getName())
              ]
          );
        },
        itemCount: badgeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      )
    );
  }
}
