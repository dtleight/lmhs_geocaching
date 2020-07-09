import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'Badge.dart';
import 'BadgeLoader.dart';
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
          //print(snapshot.data);
          if(snapshot.hasData)
            {
              List<Badge> lb = List<Badge>.from(snapshot.data);
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
    print(jsonString);
    final jsonResponse = json.decode(jsonString);
    BadgeLoader bl = new BadgeLoader.fromJson(jsonResponse);
    print(bl.badges);
    return bl.badges;
  }
}
