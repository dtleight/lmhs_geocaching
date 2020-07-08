import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'Badge.dart';
import 'Profile.dart';

class BadgeDisplayPage extends StatelessWidget {

  List<Badge> badgeList;

  @override
  Widget build(BuildContext context)
  {
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
        future: loadBadgeList(),
        builder: (context,snapshot)
        {
          List<Widget> children = <Widget>[Column()];
          if(snapshot.hasData)
            {
              List<Badge> lb = List<Badge>.from(snapshot.data);
              print("Data found");
              //List<BadgeLoader> badgeloaderList = parseJson(snapshot.data.toString());
              print("No messs");
              //List<Badge> badgeList = badgeloaderList.elementAt(0).badges;
              print("The issue is here");
              lb.forEach((badge)
              {
                children.add
                (
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                        [
                          InkWell(
                            child: CircleAvatar(
                                backgroundColor: Color(0xffFDCF09),
                                radius:90,                                                //badge image src
                                child: CircleAvatar(backgroundImage: AssetImage(badge.imageSRC),radius: 85,)),
                            onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(badge)));},
                          ),
                          Text(badge.name)
                        ]
                    ),
                );
              }
              );
            }
          else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }

          return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
          ),
          );
        },
      ),
    );
  }
  //
  Future<String> _loadBadgeList() async
  {
    return await rootBundle.loadString('badge-images/badge_data.json');
  }

  Future<List<Badge>> loadBadgeList() async {
    String jsonString = await _loadBadgeList();
    final jsonResponse = json.decode(jsonString);
    BadgeLoader bl = new BadgeLoader.fromJson(jsonResponse);
    return bl.badges;
  }
}

class BadgeLoader
{
  List<Badge> badges;

  BadgeLoader({this.badges});

  factory BadgeLoader.fromJson(Map<String, dynamic> parsedJson)
  {
    List<Badge> badgesList = List<Badge>();
    List<String> rawBadgeData = new List<String>.from(parsedJson['badges']);
    rawBadgeData.forEach((badgeString)
    {
      badgesList.add(Badge.fromJson(json.decode(badgeString)));
    });
    return BadgeLoader(badges: badgesList);
  }
  /**
    if (json['badges'] != null) {
      badges = new List<Badge>();
      json['badges'].forEach((v) {
        badges.add(new Badge.fromJson(v));
      });

**/
}
