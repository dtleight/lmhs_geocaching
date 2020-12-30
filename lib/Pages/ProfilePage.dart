import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Utilities/ColorTheme.dart';
import '../Singletons/Account.dart';

String dateLong = new Account().joinDate.toDate().toString();
String dateShort = dateLong.substring(0, 10);
List cacheComp = new Account().cacheCompletions;
List badgeComp = new Account().badgeCompletions;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Profile", textAlign: TextAlign.center),
      ),
      backgroundColor: ColorTheme.backgroundColor,
      body: ListView(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(new Account().imageSrc),
            radius: 45,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            new Account().name,
            style: TextStyle(
              fontSize: 30,
              color: ColorTheme.textColor,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Icon(
                    Icons.map,
                    size: 100,
                    color: Colors.green[500],
                  ),
                  Center(
                    child: Text(
                      "Caches Completed:",
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorTheme.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      cacheComp.length.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorTheme.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    size: 100,
                    color: Colors.amber[600],
                  ),
                  Center(
                    child: Text(
                      "Badges Earned:",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorTheme.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      badgeComp.length.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorTheme.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "  Join Date: " + dateShort,
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            color: ColorTheme.textColor,
          ),
        ),
      ]),
    );
  }
}
