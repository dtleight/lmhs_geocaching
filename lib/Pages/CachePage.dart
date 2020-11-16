import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';
import '../Singletons/DatabaseRouting.dart';
import 'AboutPage.dart';
import 'BadgeDisplayPage.dart';
import 'CacheInfoPage.dart';
import '../Objects/Cache.dart';
import '../Pages/HomePage.dart';
import 'ProfilePage.dart';
import 'SettingsPage.dart';

class CachePage extends StatelessWidget {
  static DatabaseRouting db;

  CachePage() {
    db = new DatabaseRouting();
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Color backgroundColor = Colors.lightBlue[300];
    Color textColor = Colors.white;

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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(new Account().name),
                accountEmail: Text(new Account().email),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(new Account().imageSrc),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/dc/8d/ef/dc8def609c27f9123c4f61a83a3b93bd.jpg"),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new ProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text('Badges'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new BadgeDisplayPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new SettingsPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.announcement),
                title: Text('About'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new AboutPage()));
                },
              )
            ],
          ),
        ),
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
                            child: InkWell(
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    child: Image.asset(
                                      thisCache.getImgSRC(),
                                    ),
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
                                      thisCache.location.latitude.toString() +
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}
