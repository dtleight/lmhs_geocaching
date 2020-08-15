import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'package:lmhsgeocaching/DatabaseRouting.dart';

import 'Badge.dart';

class BadgeDisplayPage extends StatelessWidget
{
  static DatabaseRouting db;
  BadgeDisplayPage()
  {
    db = new DatabaseRouting();
    db.loadBadges();
  }

  Widget build(BuildContext context)
  {

    return new Scaffold (
      appBar: AppBar(
        title: Text("Badges"),
      ),
      body: GridView.builder(
        itemBuilder: (context, position) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                db.badges[position].decideFilter(InkWell(
                  child: CircleAvatar(
                      backgroundColor: Color(0xffFDCF09),
                      radius:45,                                                //badge image src
                      child: CircleAvatar(backgroundImage: AssetImage(db.badges[position].imageSRC),radius: 40,)),
                  onTap: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeInfoPage(db.badges[position])));},
                )),
                Text(db.badges[position].name),
              ]
          );
        },
        itemCount: db.badges.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );
  }
}
/**
    @override
    Widget build(BuildContext context)
    {
    return new Scaffold (
    appBar: AppBar(
    title: Text("Badges"),
    ),
    body: FutureBuilder
    (
    future: db.loadBadges(),
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
 **/
