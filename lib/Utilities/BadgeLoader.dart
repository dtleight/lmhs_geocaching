import '../Objects/Badge.dart';

class BadgeLoader {
  List<Badge> badges;

  BadgeLoader(this.badges);

  factory BadgeLoader.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['badges'] as List;
    List<Badge> badgeList = list.map((i) => Badge.fromJson(i)).toList();
    return BadgeLoader(badgeList);
  }
}
