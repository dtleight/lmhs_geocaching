import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lmhsgeocaching/CacheContainer.dart';
import 'CacheInfoPage.dart';
import 'Cache.dart';

class CachePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('caches').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.documents.map((
                      DocumentSnapshot document) {
                    GeoPoint gp = document['location'];
                    double lat = gp.latitude;
                    double longitude = gp.longitude;
                    return new ListTile(
                      leading: Icon(Icons.map),
                      title: new Text(document.documentID),
                      subtitle: new Text(lat.toString() + "," + longitude.toString()),
                        onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage(new Cache(document.documentID,document['cacheID'],gp))));}
                    );
                  }).toList(),
                );
            }
          },
        ));
  }

}