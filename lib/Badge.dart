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

    isObtained = false;
  }

  ///JSON Constructor
  factory Badge.fromJson(Map<String, dynamic> json)
  {
    print("json");
    return Badge(json['name'], json['description'], json['src'], json['id'],
        json['requirement']);
  }

  /// Takes a widget and applies a grayscale filter if needed
  Widget decideFilter(Widget widget) {
    if(isObtained) {
      return widget;
    }
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(<double>[
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0.2126,0.7152,0.0722,0,0,
        0,0,0,1,0,
      ]),
      child: widget,
    );
  }

    /// Handles requirements - Account will be passed in at a later date
    bool isCompleted(Set<int> cachesCompleted) {
      print(requirement.runtimeType);

      if(requirement is int) {
        return cachesCompleted.length > requirement;
      } else if(requirement is List<int>) {
        bool test = true;
        for(int i in requirement) {
          //account.cachesCompleted
          test = test && cachesCompleted.contains(i);
        }
      return test;
      }
    return false;
    }
}