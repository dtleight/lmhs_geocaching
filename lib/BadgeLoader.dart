import 'package:lmhsgeocaching/Badge.dart';

class BadgeLoader {
  List<Badge> badges;
  BadgeLoader({this.badges});

  BadgeLoader.fromJson(Map<String, dynamic> json) {
    if (json['badges'] != null) {
      badges = new List<Badge>();
      json['badges'].forEach((v) {
        badges.add(new Badge.fromJson(v));
      });
    }
  }
}