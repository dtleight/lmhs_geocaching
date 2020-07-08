import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lmhsgeocaching/BadgeInfoPage.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'Badge.dart';
import 'Profile.dart';

class BadgeDisplayPage extends StatelessWidget {

  List<Badge> badgeList;

  @override
  Widget build(BuildContext context)
  {
    badgeList = Profile.badgeList;
    return new Scaffold (
      appBar: AppBar(
        title: Text("Badges"),
      ),
      //Implement as futureBuilder
        /**
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
                child: CircleAvatar(backgroundImage: AssetImage(badgeList[position].imageSRC),radius: 85,)),
            onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badgeList[position])));},
              ),
                Text(badgeList[position].name)
              ]
          );
        },
        itemCount: badgeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      )
        **/
      body: FutureBuilder
        (
        future: DefaultAssetBundle.of(context).loadString('badge-images/badge_data.json'),
        builder: (context,position)
        {
          return GridView.builder(
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
                          child: CircleAvatar(backgroundImage: AssetImage(badgeList[position].imageSRC),radius: 85,)),
                      onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badgeList[position])));},
                    ),
                    Text(badgeList[position].name)
                  ]
              );
            },
            itemCount: badgeList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
          /**return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                InkWell(
                  child: CircleAvatar(
                      backgroundColor: Color(0xffFDCF09),
                      radius:90,                                                //badge image src
                      child: CircleAvatar(backgroundImage: AssetImage(badgeList[position].imageSRC),radius: 85,)),
                  onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badgeList[position])));},
                ),
                Text(badgeList[position].name)
              ]
          );**/
        },
      ),
    );
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
}

class BadgeLoader
{
  List<Badge> badges;

  BadgeLoader({this.badges});

  BadgeLoader.fromJson(Map<String, dynamic> json) {
    if (json['badges'] != null) {
      badges = new List<Badge>();
      json['badges'].forEach((v) {
        badges.add(new Badge.fromJson(v));
      });
    }
  }
}
