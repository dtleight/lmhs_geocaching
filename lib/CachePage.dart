import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/DatabaseRouting.dart';
import 'CacheInfoPage.dart';

class CachePage extends StatelessWidget
{
  static DatabaseRouting db;
  CachePage()
  {
    db = new DatabaseRouting();
  }

  Widget build(BuildContext context)
  {
    return new Scaffold(
      body: ListView.builder(
          itemBuilder: (BuildContext context,int index)
          {
            return new ListTile(
                leading: Icon(Icons.map),
                title: new Text(db.caches[index].name),
                subtitle: new Text(db.caches[index].location.latitude.toString() + "," + db.caches[index].location.longitude.toString()),
                onTap: (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheInfoPage(db.caches[index])));}
            );
          }
      ),
    );
  }
}