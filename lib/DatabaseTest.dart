import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseTest extends StatelessWidget {

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
                      title: new Text(document['cacheID'].toString()),
                      subtitle: new Text(lat.toString() + "," + longitude.toString()),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }
}