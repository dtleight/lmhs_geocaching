import 'Badge.dart';
class Profile {
  String name;
  String UUID;
  DateTime joinDate;
  List<int> cacheCompletions;
  List<int> badgeCompletions;



  Profile(String name, String UUID, DateTime joinDate, List<int> cacheCompletions, List<int> badgeCompletions)
  {
   this.name = name;
   this.UUID = UUID;
   this.joinDate = joinDate;
   this.cacheCompletions = cacheCompletions;
   this.badgeCompletions = badgeCompletions;
  }
  //TODO: Write profile info to the database
  String sort='alpha';
/**
  //this should automatically run whenever the user goes to look at his/her badges
    //for(var i=0; i<badgeList.length; i++){

    alphasort()  {

    }

    topicsort() {

    }

    newestsort() {

  }
    **/
}
