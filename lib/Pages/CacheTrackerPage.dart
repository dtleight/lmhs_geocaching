import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Pages/CacheNotFoundPage.dart';
import '../Widgets/Compass.dart';
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
      Text("Tomato"),
      Text("Mashed Tomato")];
  }
  @override
  Widget build(BuildContext context)
  {
   return Scaffold(
     appBar: AppBar(title: Text("Cache Tracker"),leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);},),),
     bottomNavigationBar: BottomNavigationBar
       (
       items:
       [
          BottomNavigationBarItem( icon: Icon(Icons.adjust_sharp), label: "Compass"),
         BottomNavigationBarItem( icon: Icon(Icons.book), label: "Log Book"),
         BottomNavigationBarItem( icon: Icon(Icons.qr_code), label: "QR Code"),
       ],
       onTap: (int index){ setState(() {selectedIndex = index;});},
     ),
     body: Column(children: [Expanded(child: widgets[selectedIndex])]),
   );
  }

}