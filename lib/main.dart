import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lmhsgeocaching/Containers/LoginContainer.dart';
import 'package:lmhsgeocaching/Pages/HomePage.dart';

import 'Singletons/Account.dart';

User? authUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  String? token = await FirebaseMessaging.instance.getToken();
  print("FIREBASE TOKEN: " + token!);
  FirebaseAuth.instance.userChanges().listen((event) async {
    authUser = event;
    if (authUser != null) {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await collectionReference.doc(uid).get();
      print("UID: $uid");
      //If an account exists for this user, query data from the database
      if (snapshot.exists) {
        List<dynamic> items = [];
        items.map((e) => e as int);
        Account.fromDatabase(
          snapshot.get('name'),
          snapshot.get('email'),
          FirebaseAuth.instance.currentUser!.photoURL!,
          (snapshot.get('joinDate') as Timestamp),
          List<int>.from(snapshot.get('cachesCompleted')),
          List<int>.from(snapshot.get('badgesCompleted')),
        );
      }
    }
  });

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMHS Geocaching',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: authUser == null ? LoginContainer() : HomePage(),
      //PageContainer()
    );
  }
}
