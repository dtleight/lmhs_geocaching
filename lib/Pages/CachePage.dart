import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Singletons/DatabaseRouting.dart';
import 'CacheInfoPage.dart';
import '../Objects/Cache.dart';

class CachePage extends StatelessWidget {
  static DatabaseRouting db;

  CachePage() {
    db = new DatabaseRouting();
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Color backgroundColor = Colors.blue;
    Color textColor = Colors.white;

    ///Page Context
    return new Scaffold(
        backgroundColor: backgroundColor,

        ///Vertical List of Categories
        body: ListView.builder(
            itemCount: db.collections.length,
            itemBuilder: (BuildContext context, int index) {
              List<Cache> caches = db.collections[index].caches;
              print("caches.length" + caches.length.toString());

              ///Category Title
              return Column(
                children: <Widget>[
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        db.collections[index].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),

                  ///Category Caches
                  Container(
                      height: 75.0,

                      ///Horizontal List of Caches
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: caches.length,
                          itemBuilder: (BuildContext context, int j) {
                            Cache thisCache = caches[j];
                            return new Container(
                              height: 400,
                              width: 150,
                              child: Card(
                                child: InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          thisCache.getImgSRC(),
                                          height: 40,
                                          width: 40,
                                        ),
                                        Center(
                                            child: Text(
                                          thisCache.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        )),
                                        Center(
                                            child: Text(
                                          thisCache.location.latitude
                                                  .toString() +
                                              ", " +
                                              thisCache.location.longitude
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (ctxt) =>
                                                  new CacheInfoPage(
                                                      thisCache)));
                                    }),
                              ),
                            );
                          })),
                ],
              );
            }));
  }
}
