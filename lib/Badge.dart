import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Badge
{
  String name;
  int badgeID;
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;
  dynamic requirement;

  ///General Constructor
  Badge(String name, String description, String src, int ID) {
    this.name = name;
    this.imageSRC = src;
    isObtained = false;
    badgeID = ID;

  }
  ///JSON Constructor
  factory Badge.fromJson(Map<String, dynamic> json)
  {
    return Badge(json['name'], json['description'], json['src'], json['id']);
    //requirement = json['requirement'];
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
    //TODO: Fix error caused by the above line - doesn't like the file paths given to it
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