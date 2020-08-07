import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/DatabaseRouting.dart';
import 'CacheInfoPage.dart';
import 'Cache.dart';

class CachePage extends StatelessWidget
{
  static DatabaseRouting db;
  CachePage()
  {
    db = new DatabaseRouting();
  }

  Widget build(BuildContext context)
  {
    ///Page Context
    return new Scaffold(
      //This will turn into a ListView.builder for all collections. Plus nearby and all caches.
      ///List of lists
      body: ListView
        (
          children: <Widget>
          [
            buildListThumbnail(),
            buildListThumbnail(),
          ],
      ),
    );
  }
  ListView buildScrollableList(List<Cache> caches)
  {
    return ListView.builder
    (
        scrollDirection: Axis.horizontal,
        itemCount: caches.length,
        itemBuilder: (BuildContext context,int index)
        {
          return new Container
            (
            width: 230,
            child: ListTile
              (
                leading: Icon(Icons.map),
                title: new Text(caches[index].name),
                subtitle: new Text(
                    caches[index].location.latitude.toString() + "," + caches[index].location.longitude.toString()),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (ctxt) => new CacheInfoPage(caches[index])));
                }
            ),
          );
        }
    );
  }
  Column buildListThumbnail()
  {
    return Column
      (
      children: <Widget>
      [
        Align(child: Text("All Caches", textAlign: TextAlign.left), alignment: Alignment.centerLeft,),
        Container(
            //margin: EdgeInsets.symmetric(vertical: 100.0),
            height: 75.0,
            child: buildScrollableList(db.caches)
        ),
      ],
    );
  }
}

