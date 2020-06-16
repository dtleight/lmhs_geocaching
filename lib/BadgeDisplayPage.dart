import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/BadgeInfoPage.dart';

import 'Badge.dart';

class BadgeDisplayPage extends StatelessWidget {

  List<Badge> badgeList;
  List<String> badgeIconFiles;

  @override
  Widget build(BuildContext context) {
    badgeList = new List<Badge>();
    badgeList.add(new Badge("School", "badge-images/school.jpg"));
    badgeList.add(new Badge("Church", "badge-images/church.jpg"));
    badgeList.add(new Badge("Barn", "badge-images/barn.jpg"));



    return new Scaffold(
      appBar: AppBar(
        title: Text("Badges"),
      ),

      body: GridView.builder(
        itemBuilder: (context, position) {
          return Card(
            child: FlatButton(
              child: Image(image: AssetImage(badgeList[position].getSrc())),
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
