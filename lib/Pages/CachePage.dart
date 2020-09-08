import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Singletons/DatabaseRouting.dart';
import 'CacheInfoPage.dart';
import '../Objects/Cache.dart';

class CachePage extends StatelessWidget
{
  static DatabaseRouting db;
  CachePage()
  {
    db = new DatabaseRouting();
  }

  Widget build(BuildContext context)
  {
    print(db.iCaches[1].name);
    ///Page Context
    return new Scaffold(
        body: ListView.builder
        (
          itemCount: db.collections.length,
          itemBuilder: (BuildContext context,int index)
          {
            print(db.collections[index].caches.length);
            return buildListThumbnail(db.collections[index].name, db.collections[index].caches);
          }
      )
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
  Column buildListThumbnail(String title, List<Cache> cacheList)
  {

    //db.writeCompletionCodes();
    return Column
      (
      children: <Widget>
      [
        Align(child: Text(title, textAlign: TextAlign.left, style: TextStyle(fontSize: 20),), alignment: Alignment.centerLeft, ),
        Container(
            //margin: EdgeInsets.symmetric(vertical: 100.0),
            height: 75.0,
            child: buildScrollableList(cacheList)
        ),
      ],
    );
  }
}

