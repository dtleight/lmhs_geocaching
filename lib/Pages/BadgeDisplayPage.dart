import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Pages/BadgeInfoPage.dart';
import '../Singletons/DatabaseRouting.dart';
import '../Objects/Badge.dart';

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
