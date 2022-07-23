import '../Objects/Collection.dart';

class Collections {
  List<Collection> collections;

  Collections(this.collections);

  factory Collections.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['collections'] as List;
    List<Collection> cols = list.map((i) => Collection.fromJson(i)).toList();
    return Collections(cols);
  }
}
