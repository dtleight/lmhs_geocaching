import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lmhsgeocaching/Pages/HomePage.dart';
import 'package:lmhsgeocaching/Pages/Login/LoginPage.dart';
import 'package:lmhsgeocaching/Pages/Login/RegisterPage.dart';
//import 'package:evercast/Pages/Onboarding/IntroScreens.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///LoginContainer is responsible for handling navigation and authentication events
/// from the login flow model. Currently the login flow supports the following:
/// Login Page, RegisterPage. Navigation is handled by updating the active widget
/// object to a given page. This allows for the container to maintain its state
/// throughout the entire login flow.
class LoginContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginContainerState();
  }
}

class LoginContainerState extends State<LoginContainer> {
  List<Widget> screens;
  Widget active;
  //Substitute for information providing enums. Not super ideal due to forced string representations
  Map<String, int> enumRelations = {
    "LoginPage": 0,
    "RegisterPage": 1,
    "RegistrationInfoPage": 2
  };

  ///The list of Screen Widgets must be defined here to allow for dependency
  ///injection. Sets the initial state to display LoginPage.
  @override
  void initState() {
    screens = [
      LoginPage(this),
      RegisterPage(this),
    ];
    active = screens[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [active],
        ));
  }

  ///Avoids the need for a navigation stack to handle login page manipulation
  void updateState(String page) {
    active = screens[enumRelations[page]];
    setState(() {});
  }

  void moveToHomePage() async {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (ctxt) {
          return HomePage();
        }), (Route<dynamic> route) => false);
  }


  void checkRegistrationStatus() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");
    DocumentSnapshot snapshot = await collectionReference.doc(uid).get();
    print(uid);
    if (snapshot.exists) //An account exists for this user, query data from the database
        {
      List<dynamic> items = [];
      items.map((e) => e as int);
      Account.fromDatabase(
          snapshot.get('name'),
          snapshot.get('email'),
          FirebaseAuth.instance.currentUser.photoURL,
          (snapshot.get('joinDate') as Timestamp),
          List<int>.from(snapshot.get('cachesCompleted').map((e) => e as int)),
          List<int>.from(snapshot.get('badgesCompleted').map((e) => e as int)),
          );
      moveToHomePage();
    }
    else{
      createUser();
    }
  }

  void createUser() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    String name = FirebaseAuth.instance.currentUser.displayName;
    String email = FirebaseAuth.instance.currentUser.email;
    String imageSRC = FirebaseAuth.instance.currentUser.photoURL;
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      'name': name,
      'email': email,
      'badgesCompleted': [],
      'cachesCompleted' :[],
      'joinDate': Timestamp.fromDate(DateTime.now()),
    });
    //Instantiate UserAccount singleton
    Account.instantiate(
        name, email, imageSRC, Timestamp.fromDate(DateTime.now()));
    moveToHomePage();
  }
}