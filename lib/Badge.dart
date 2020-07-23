import 'dart:io';
import 'package:image/image.dart' as dart;


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Badge {
  String name;
  int badgeID;
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;
  dynamic requirement;

  ///General Constructor
  Badge(String name, String description, String src, int ID,
      dynamic requirement) {
    this.name = name;
    this.description = description;
    this.imageSRC = src;
    this.badgeID = ID;
    this.requirement = requirement;

    isObtained = true;
  }

  ///JSON Constructor
  factory Badge.fromJson(Map<String, dynamic> json)
  {
    print("json");
    return Badge(json['name'], json['description'], json['src'], json['id'],
        json['requirement']);
  }

  dynamic getImage() {
    if (isObtained) {
      return Image.asset(imageSRC);
    }

    return ColorFiltered(
      colorFilter: ColorFilter.matrix(<double>[
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0,0,0,1,0,
      ]),
      child: Image.asset(imageSRC),
    );
  }

/*getImage() {
    print("got not"); // Do not question my debugging tactics
    File file = new File(imageSRC);
    print("got milk");

    List<int> bytes = file.readAsBytesSync();
    //TODO: Fix error caused by the above line - doesn't like the file paths given to it
    print("got here");
    Image img = decodeJpg(bytes);
    if(isObtained)
      {
        return img.getBytes();
      }
    return grayscale(img).getBytes();
  }*/

    /// Handles requirements
    bool isCompleted(Set<int> cachesCompleted) {
      print(requirement.runtimeType);

      if(requirement is int) {
        return cachesCompleted.length > requirement;
      } else if(requirement is List<int>) {
        bool test = true;
        for(int i in requirement) {
          test = test && cachesCompleted.contains(i);
        }
      return test;
      }
    return false;
    }
}