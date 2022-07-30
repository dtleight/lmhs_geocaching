import 'package:cloud_firestore/cloud_firestore.dart';
import '../Singletons/DatabaseRouting.dart';
import '../Objects/Cache.dart';

class Account {
  late String name;
  late String email;
  late String imageSrc;
  late Timestamp joinDate;
  late List<int> cacheCompletions;
  late List<int> badgeCompletions;

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
    _account.cacheCompletions = <int>[];
    _account.badgeCompletions = <int>[];
    return _account;
  }

  factory Account.fromDatabase(
      String name,
      String email,
      String imageSRC,
      Timestamp joinDate,
      List<int> cacheCompletions,
      List<int> badgeCompletions) {
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
          badgeCompletions.add(badge.badgeID);
        }
      }
    });
  }
}
