import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/ProfilePage.dart';
import 'package:lmhsgeocaching/BadgeDisplayPage.dart';

class UtilitySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new ProfilePage()));} ,
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Badges'),
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new BadgeDisplayPage()));} ,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}