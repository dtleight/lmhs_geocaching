import '../Objects/Cache.dart';
import '../Singletons/DatabaseRouting.dart';

class Collection
{
  String name;
  int collectionID;
  List<Cache>  caches = new List<Cache>();

  Collection(String name, int collectionID, List<int> cacheIds)
  {
    this.name = name;
    this.collectionID = collectionID;
    for(int id in cacheIds)
    {
      caches.add(new DatabaseRouting().caches[id]);
    }
  }
  factory Collection.fromJson(Map<String, dynamic> json)
  {
    return Collection(json["name"],json["colID"],json['cacheIds']);
  }
}