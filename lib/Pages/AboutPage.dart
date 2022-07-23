import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: ListView(children: <Widget>[
        ListTile(
          leading: Icon(Icons.announcement),
          title: Text('Licensing'),
        ),
      ]),
    );
  }
}
