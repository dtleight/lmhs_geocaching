import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Singletons/Account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String dateLong = new Account().joinDate.toDate().toString();
String dateShort = dateLong.substring(0,10);
List cacheComp = new Account().cacheCompletions;
List badgeComp = new Account().badgeCompletions;

class ProfilePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold (
      appBar: AppBar(
        title: Text("Profile: " + new Account().name,
        textAlign: TextAlign.center
        ),
      ),
      body: ListView(
        children: <Widget>[
      UserAccountsDrawerHeader(
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(new Account().imageSrc),
            ),
          ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                "https://i.pinimg.com/originals/dc/8d/ef/dc8def609c27f9123c4f61a83a3b93bd.jpg"
            ),
          ),
        ),
      ),
          Text("Your Stats",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 30),
          ),
          SizedBox(
            height: 25,
          ),
          Text("Join Date: " + dateShort,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 15),
          ),
          Text("Caches Completed:" + cacheComp.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
              fontSize: 15),
          ),
          Text("Badges Earned:" + badgeComp.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 15),
          )
      ]),
      );
  }
}