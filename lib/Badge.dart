import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:image/image.dart';

class Badge
{
  String name;
  int badgeID;
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;

  int _cachesCollected;
  int _cachesNeeded;


  //Constructor
  Badge(String name, String src, int need, int ID) {
    this.name = name;
    this.imageSRC = src;
    isObtained = false;
    badgeID = ID;

    _cachesCollected = 0;
    _cachesNeeded = need;
  }

  Image getImage()
  {
    return Image.asset("filepath");
  }
  /*getImage() {
    print("got not"); // Do not question my debugging tactics
    File file = new File(imageSRC);
    print("got milk");
    List<int> bytes = file.readAsBytesSync();
    //TODO: Fix error caused by the above line - doens't like the file paths given to it
    print("got here");
    Image img = decodeJpg(bytes);
    print("got there");
    if(isObtained)
      {
        return img.getBytes();
      }
    return grayscale(img).getBytes();
  }*/

  updateBadges()
  {
    //for each badge, call checkObtained
  }
}