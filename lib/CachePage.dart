import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/CacheContainer.dart';
import 'CacheInfoPage.dart';

class CachePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #1'),
            //onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage()));} ,
              onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheContainer()));} ,
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #2'),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Cache Title #3'),
          ),
        ],
      ),
    );
  }
}