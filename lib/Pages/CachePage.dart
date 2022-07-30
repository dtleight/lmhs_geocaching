import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';
import 'package:lmhsgeocaching/Widgets/UserDrawer.dart';
import '../Singletons/DatabaseRouting.dart';
import 'CacheInfoPage.dart';
import '../Objects/Cache.dart';
import '../Pages/HomePage.dart';
import '../Utilities/ColorTheme.dart';

class CachePage extends StatelessWidget {
  final DatabaseRouting db;

  CachePage() : db = new DatabaseRouting() {
    db.loadPicture("mill.jpg");
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    ///Page Context
    return new Scaffold(
        appBar: AppBar(title: Text("LMTHS Geocaching"), actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (ctxt) => new HomePage()));
                },
                child: Icon(
                  Icons.map,
                  size: 26.0,
                ),
              )),
        ]),
        drawer: UserDrawer(),
        backgroundColor: ColorTheme.backgroundColor,

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
                          fontSize: 25,
                          color: ColorTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),

                  ///Category Caches
                  AspectRatio(
                    aspectRatio: 5 / 2,

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
                            color: Colors.grey[200],
                            child: Stack(
                              children: [
                                InkWell(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: FutureBuilder(
                                          future:
                                              db.loadPicture(thisCache.imgSRC),
                                          builder: (context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.hasData) {
                                              return Image.network(
                                                snapshot.data!,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProcess) {
                                                  if (loadingProcess == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                      value: loadingProcess
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProcess
                                                                  .cumulativeBytesLoaded /
                                                              loadingProcess
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ));
                                                  }
                                                },
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                        //child: Image.network(db.loadPicture()),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Center(
                                            child: Text(
                                          thisCache.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        )),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Center(
                                            child: Text(
                                          thisCache.location.latitude
                                                  .toString() +
                                              ", " +
                                              thisCache.location.longitude
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 10),
                                        )),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (ctxt) =>
                                                new CacheInfoPage(thisCache)));
                                  },
                                ),
                                Visibility(
                                    visible: Account().cacheCompletions.contains(thisCache.cacheID),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 50.0,
                                        )))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }

  Future<Widget> getImage(String image) async {
    var url =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return Image.network(url);
  }
}
