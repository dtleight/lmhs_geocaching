import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
class DatabaseRouting
{
  Future<QuerySnapshot> loadDatabase(String collection) async
  {
    CollectionReference ref = Firestore.instance.collection(collection);
    return await ref.getDocuments();
  }

  //Writes to each element
  void createUser() async
  {
    QuerySnapshot querySnapshot = await loadDatabase('users');
    querySnapshot.documents.forEach((element)
    {
      element.reference.updateData({'uuid': "Random UUID"});
    }
    );
  }

  //Creates a new user
  void createUser2() async
  {
    Firestore.instance.collection('users').add({'uuid':"Random", "caches_completed": 1});
  }
  //Updates a users data
  void updateUser() async
  {
    Firestore.instance.collection('users').document('customer1').updateData({'uuid':'RandomUUID'});
  }
}