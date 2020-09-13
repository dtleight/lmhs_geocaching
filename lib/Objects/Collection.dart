import '../Objects/Cache.dart';
import '../Singletons/DatabaseRouting.dart';

class Collection
{
  String name;
  int collectionID;
  List<Cache>  caches = new List<Cache>();
  //Code is sloppy for now, fix later
  Collection(String name, int collectionID, List<int> cacheIds)
  {
    print(cacheIds);
    this.name = name;
    this.collectionID = collectionID;
    for(int id in cacheIds)
    {
      caches.add( new DatabaseRouting().iCaches[id]);
    }
  }
  factory Collection.fromJson(Map<String, dynamic> json)
  {
    var cacheIds = json['cacheIds'] as List;
    return Collection(json["name"],json["colID"],cacheIds.map((id) => id as int).toList());
  }
}