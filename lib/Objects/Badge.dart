import 'dart:io';
import 'package:image/image.dart' as dart;


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';
import 'package:lmhsgeocaching/Singletons/DatabaseRouting.dart';

class Badge {
  String name;
  int badgeID;
  String imageSRC;
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
  }

  ///JSON Constructor
  factory Badge.fromJson(Map<String, dynamic> json)
  {
    return Badge(json['name'], json['description'], json['src'], json['id'],
        json['requirement']);
  }

  /// Takes a widget and applies a grayscale filter if needed

  Widget decideFilter(Widget widget) {
    /// Check whether or not this badge has been obtained
    bool obtained = false;
    for(int id in Account().badgeCompletions) {
      if(id == this.badgeID){obtained = true; break;}
    }


    if(obtained) {
      return widget;
    } else {
      return ColorFiltered(
        colorFilter: ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
               0,      0,      0, 1, 0,
        ]),
        child: widget,
      );
    }
  }


    double getProgress() {
    List<int> cachesCompleted = List<int>();
    cachesCompleted.add(1);
    if(requirement is int) {
      return cachesCompleted.length / (requirement.toDouble());
    } else {
      double requiredCachesCompleted = 0;
      for(int cache in cachesCompleted) {
        if(requirement.indexOf(cache) >= 0) {
          requiredCachesCompleted++;
        }
      }
      return requiredCachesCompleted / requirement.length;
    }
  }

    /// Handles requirements
    bool isCompleted(List<dynamic> cachesCompleted) {
      print(requirement.runtimeType);

      if(requirement is int) {
        return cachesCompleted.length >= requirement;
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
