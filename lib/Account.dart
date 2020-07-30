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
  Set<int> cacheCompletions;
  Set<int> badgeCompletions;

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
    _account.cacheCompletions = new Set<int>();
    _account.badgeCompletions = new Set<int>();
    new DatabaseRouting().createUser(_account);
    return _account;
  }
  Account._internal();

  void init()
  {

  }




  /**
   *
  Account(String name, String UUID, Timestamp joinDate, Set<int> cacheCompletions, Set<int> badgeCompletions)
  {
    this.name = name;
    this.UUID = UUID;
    this.joinDate = joinDate;
    this.cacheCompletions = cacheCompletions;
    this.badgeCompletions = badgeCompletions;
  }

  Account.init(String name, String UUID, Timestamp joinDate)
  {
    this.name = name;
    this.UUID = UUID;
    this.joinDate = joinDate;
    this.cacheCompletions = new Set<int>();
    this.badgeCompletions = new Set<int>();
    new DatabaseRouting().createUser(this);
  }
      **/

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