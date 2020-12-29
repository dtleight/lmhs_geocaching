import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Pages/CacheNotFoundPage.dart';
import 'package:lmhsgeocaching/Widgets/QRCodeReader.dart';
import '../Widgets/Compass.dart';
import '../Widgets/CacheMap.dart';
class CacheTrackerPage extends StatefulWidget
{
  Cache cache;
  CacheTrackerPage(Cache cache)
  {
    this.cache = cache;
  }


  @override
  State<StatefulWidget> createState() {
    return CacheTrackerPageState(cache);
  }
}

class CacheTrackerPageState extends State<CacheTrackerPage>
{
  int selectedIndex;
  Cache cache;
  List<Widget> widgets;
  CacheTrackerPageState(Cache cache)
  {
    this.cache = cache;
    this.selectedIndex = 0;
    widgets = [
      Compass(targetLoc: LatLng((cache.location as GeoPoint).latitude,(cache.location as GeoPoint).longitude)),
      Text("Mashed Tomato"),
      QRCodeReader(cache),
      CacheMap(cache),
    ];
  }
  @override
  Widget build(BuildContext context)
  {
   return Scaffold(
     backgroundColor: Colors.black,
     appBar: AppBar(title: Text("Cache Tracker"),leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);},),),
     bottomNavigationBar: BottomNavigationBar
       (
       type: BottomNavigationBarType.fixed,
       items:
       [
          BottomNavigationBarItem( icon: Icon(Icons.adjust_sharp), label: "Compass"),
          BottomNavigationBarItem( icon: Icon(Icons.book), label: "Log Book"),
          BottomNavigationBarItem( icon: Icon(Icons.qr_code), label: "QR Code"),
          BottomNavigationBarItem( icon: Icon(Icons.map), label: "Map"),
       ],
       onTap: (int index){ setState(() {selectedIndex = index;});},
     ),
     body: Column(children: [Expanded(child: widgets[selectedIndex])]),
   );
  }

}