import 'package:lmhsgeocaching/Badge.dart';

class BadgeLoader
{
  List<Badge> badges;

  BadgeLoader({this.badges});

  factory BadgeLoader.fromJson(Map<String, dynamic> parsedJson)
  {
    print(parsedJson['badges']);
    var list = parsedJson['badges'] as List;
    List<Badge> badgeList = list.map((i) => Badge.fromJson(i)).toList();
    return BadgeLoader(badges: badgeList);
  }
}