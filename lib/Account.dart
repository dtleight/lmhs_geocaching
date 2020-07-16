import 'package:cloud_firestore/cloud_firestore.dart';
import 'Cache.dart';
import 'Badge.dart';

class Account
{
  final List<Badge> badges = new List();
  String name;
  String UUID;
  Timestamp joinDate;
  Set<int> cacheCompletions;
  Set<int> badgeCompletions;

  Account(String name, String UUID, Timestamp joinDate, Set<int> cacheCompletions, Set<int> badgeCompletions)
  {
    this.name = name;
    this.UUID = UUID;
    this.joinDate = joinDate;
    this.cacheCompletions = cacheCompletions;
    this.badgeCompletions = badgeCompletions;
  }

  onCacheCompletion(Cache c)
  {
    cacheCompletions.add(c.cacheID);
    updateBadges();
  }

  updateBadges()
  {
    badges.forEach( (badge)
    {
      if(badge.isCompleted())
        {
          badgeCompletions.add(badge.badgeID);
        }
    }
    );
  }



}