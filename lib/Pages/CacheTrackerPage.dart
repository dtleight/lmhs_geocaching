import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Widgets/QRCodeReader.dart';
import '../Widgets/Compass.dart';
import '../Widgets/CacheMap.dart';
import '../Widgets/LogBook.dart';

class CacheTrackerPage extends StatefulWidget {
  final List<Widget> widgets;

  CacheTrackerPage(Cache cache)
      : this.widgets = [
          Compass(cache.location),
          LogBook(cache),
          QRCodeReader(cache),
          CacheMap(cache),
        ];

  @override
  State<StatefulWidget> createState() => CacheTrackerPageState();
}

class CacheTrackerPageState extends State<CacheTrackerPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Cache Tracker"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust_sharp),
            label: "Compass",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Log Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: "QR Code",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
        ],
        onTap: (index) => setState(() => selectedIndex = index),
      ),
      body: Column(
        children: [
          Expanded(child: widget.widgets[selectedIndex]),
        ],
      ),
    );
  }
}
