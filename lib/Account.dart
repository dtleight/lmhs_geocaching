import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lmhsgeocaching/DatabaseRouting.dart';
import 'Cache.dart';
import 'Badge.dart';

class Account
{
  String name;
  String email;
  String imageSrc;
  Timestamp joinDate;
  List<int> cacheCompletions;
  List<int> badgeCompletions;

  static final Account _account = Account._internal();

  factory Account()
  {
    return _account;
  }

  factory Account.instantiate(String name, String email, String imageSRC, Timestamp joinDate)
  {
    _account.name = name;
    _account.email = email;
    _account.imageSrc = imageSRC;
    _account.joinDate = joinDate;
    _account.cacheCompletions = new List<int>();
    _account.badgeCompletions = new List<int>();
    return _account;
  }

  factory Account.fromDatabase(String name, String email, String imageSRC, Timestamp joinDate, List<int> cacheCompletions, List<int> badgeCompletions)
  {
    _account.name = name;
    _account.email = email;
    _account.imageSrc = imageSRC;
    _account.joinDate = joinDate;
    _account.cacheCompletions = cacheCompletions;
    _account.badgeCompletions =badgeCompletions;
    return _account;
  }
  Account._internal();

  void init() {}

  onCacheCompletion(Cache c)
  {
    cacheCompletions.add(c.cacheID);
    updateBadges();
  }

  updateBadges()
  {
    new DatabaseRouting().badges.forEach( (badge)
    {
      if(badge.isCompleted(cacheCompletions))
        {
          badgeCompletions.add(badge.badgeID);
        }
    }
    );
  }
}