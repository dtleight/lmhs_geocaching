import 'package:flutter/material.dart';
import '../Pages/AboutPage.dart';
import '../Pages/ProfilePage.dart';
import '../Pages/BadgeDisplayPage.dart';
import 'package:lmhsgeocaching/Pages/SettingsPage.dart';

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
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new SettingsPage()));} ,
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('About'),
            onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new AboutPage()));} ,
          ),
        ],
      ),
    );
  }
}