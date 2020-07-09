import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'Badge.dart';
import 'BadgeLoader.dart';

class BadgeDisplayPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold (
      appBar: AppBar(
        title: Text("Badges"),
      ),
      body: FutureBuilder
        (
        future: loadBadgeList(),
        builder: (context,snapshot)
        {
          List<Widget> children = <Widget>[Column()];
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

  ///
  /// Loads JSON file from assets
  ///
  Future<String> _loadBadgeList() async
  {
    return await rootBundle.loadString('badge-images/badge_data.json');
  }

  ///
  /// Retrieves list data from JSON file
  ///
  Future<List<Badge>> loadBadgeList() async {
    String jsonString = await _loadBadgeList();
    final jsonResponse = json.decode(jsonString);
    BadgeLoader bl = new BadgeLoader.fromJson(jsonResponse);
    return bl.badges;
  }
}
