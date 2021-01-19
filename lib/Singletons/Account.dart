import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Singletons/DatabaseRouting.dart';
import '../Objects/Cache.dart';
import '../Objects/Badge.dart';

class Account {
  String name;
  String email;
  String imageSrc;
  Timestamp joinDate;
  List<dynamic> cacheCompletions;
  List<dynamic> badgeCompletions;

  static final Account _account = Account._internal();

  factory Account() {
    return _account;
  }

  factory Account.instantiate(
      String name, String email, String imageSRC, Timestamp joinDate) {
    _account.name = name;
    _account.email = email;
    _account.imageSrc = imageSRC;
    _account.joinDate = joinDate;
    _account.cacheCompletions = new List<dynamic>();
    _account.badgeCompletions = new List<dynamic>();
    return _account;
  }

  factory Account.fromDatabase(
      String name,
      String email,
      String imageSRC,
      Timestamp joinDate,
      List<dynamic> cacheCompletions,
      List<dynamic> badgeCompletions) {
    _account.name = name;
    _account.email = email;
    _account.imageSrc = imageSRC;
    _account.joinDate = joinDate;
    _account.cacheCompletions = cacheCompletions;
    _account.badgeCompletions = badgeCompletions;
    return _account;
  }

  Account._internal();

  void init() {}

  onCacheCompletion(Cache c) {
    if (!cacheCompletions.contains(c.cacheID)) {
      cacheCompletions.add(c.cacheID);
    }
    updateBadges();
    new DatabaseRouting().updateAccount(this);
  }

  updateBadges() {
    new DatabaseRouting().badges.forEach((badge) {
      if (badge.isCompleted(cacheCompletions)) {
        if (!badgeCompletions.contains(badge.badgeID)) {
          badgeCompletions.add({
            "badgeID": badge.badgeID,
            "completionDate": Timestamp.now()
          });
        }
      }
    });
  }
}
