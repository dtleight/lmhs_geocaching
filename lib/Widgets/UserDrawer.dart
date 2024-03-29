import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lmhsgeocaching/Containers/LoginContainer.dart';
import 'package:lmhsgeocaching/Pages/AboutPage.dart';
import 'package:lmhsgeocaching/Pages/BadgeDisplayPage.dart';
import 'package:lmhsgeocaching/Pages/ProfilePage.dart';
import 'package:lmhsgeocaching/Pages/SettingsPage.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';

class UserDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(new Account().name),
            accountEmail: Text(new Account().email),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(new Account().imageSrc),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://dtjew9b6f6zyn.cloudfront.net/wp-content/uploads/2015/10/800px-Elk_State_Forest_Humps.jpg"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new ProfilePage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Badges'),
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new BadgeDisplayPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('About'),
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new AboutPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Bug Report'),
            onTap: () => FlutterEmailSender.send(Email(
                subject: "Bug Report",
                recipients: ["lmthistoryapps@gmail.com"],
                body: "Account Email: " +
                    Account().email +
                    "\n\nBug Description:\n\n")),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(builder: (ctxt) => new SettingsPage()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => true);
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new LoginContainer()),
              );
            },
          ),
        ],
      ),
    );
  }
}
