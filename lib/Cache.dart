import 'Badge.dart';

class Cache {

  List<Badge> _badgeCompletionList;

  Cache() {}

  //TODO: Instantiate _badgeCompletionList based on Badge's in Profile.dart

  void found() {
    for(Badge badge in _badgeCompletionList) {
      badge.cacheFound();
    }
  }

}