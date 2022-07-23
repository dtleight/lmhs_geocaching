import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Objects/Cache.dart';
import '../Objects/Badge.dart';
import '../Objects/Collection.dart';
import 'Account.dart';
import '../Utilities/BadgeLoader.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import '../Utilities/Collections.dart';

class DatabaseRouting {
  static final DatabaseRouting _db = DatabaseRouting._internal();
  late Map<int, Cache> iCaches;
  late List<Cache> caches;
  late Set<Marker Function(BuildContext context)> markerBuildFunctions;
  late List<Badge> badges;
  late List<Collection> collections;
  late BuildContext context;

  factory DatabaseRouting() {
    return _db;
  }

  DatabaseRouting._internal();

  void init() async {
    await loadCaches();
    await loadBadges();
    await loadCollections();
  }

  Future<QuerySnapshot> loadDatabase(String collection) async {
    CollectionReference ref = FirebaseFirestore.instance.collection(collection);
    return await ref.get();
  }

  loadCaches() async {
    markerBuildFunctions = Set();
    caches = [];
    iCaches = {};
    CollectionReference ref = FirebaseFirestore.instance.collection('caches');
    QuerySnapshot eventsQuery = await ref.get();
    eventsQuery.docs.forEach((document) {
      String tempImgSRC = document['imgSRC'];
      tempImgSRC = tempImgSRC.isNotEmpty ? tempImgSRC : 'mill.jpg';
      String tempDescription = document['description'];
      tempDescription = tempDescription.isNotEmpty
          ? tempDescription
          : 'This is the history of the place.';
      String tempInstructions = document['instructions'];
      tempInstructions = tempInstructions.replaceAll("\\n", "\n");
      tempInstructions = tempInstructions.isNotEmpty
          ? tempInstructions
          : 'These are the instructions to find the cache.';
      String tempHint = document['hint'];
      tempHint = tempHint.isNotEmpty
          ? tempHint
          : 'This is a hint to help you find where the cache is hidden.';

      Cache temp = new Cache(
        document.id,
        document['cacheID'],
        document['completionCode'],
        document['location'],
        tempImgSRC,
        tempDescription,
        tempInstructions,
        tempHint,
      );
      caches.add(temp);
      iCaches[document['cacheID']] = temp;
      markerBuildFunctions.add(temp.buildMarker);
    });
  }

  ///
  /// Loads JSON file from assets
  ///
  Future<String> _loadBadgeList() async {
    return await rootBundle.loadString('badge-images/badge_data.json');
  }

  ///
  /// Retrieves list data from JSON file
  ///
  loadBadges() async {
    String jsonString = await _loadBadgeList();
    final jsonResponse = json.decode(jsonString);
    //Parses a JSON-formatted String and returns a wrapper class for a list of Badge objects
    BadgeLoader bl = new BadgeLoader.fromJson(jsonResponse);
    badges = bl.badges;
  }

  ///
  /// Loads JSON file from assets
  ///
  Future<String> _loadCollections() async {
    return await rootBundle.loadString('badge-images/collection_data.json');
  }

  ///
  /// Retrieves list data from JSON file
  ///
  loadCollections() async {
    String jsonString = await _loadCollections();
    final jsonResponse = json.decode(jsonString);
    Collections cl = new Collections.fromJson(jsonResponse);
    collections = cl.collections;
  }

  Future<String> loadPicture(String filename) async {
    String image =
        await FirebaseStorage.instance.ref().child(filename).getDownloadURL();
    return image;
  }

  ///
  /// Saves data to account - Needs to be changed
  ///
  updateAccount(Account a) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'cachesCompleted': a.cacheCompletions,
      'badgesCompleted': a.badgeCompletions
    });
  }

  ///Temporary Methods
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/qrcodes.txt');
  }

  Future<File> write(String qrcode) async {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString(qrcode);
  }

  ///
  /// Update cache descriptions-unused
  ///
  void writeToCaches() async {
    for (Cache cache in this.caches) {
      await FirebaseFirestore.instance
          .collection('caches')
          .doc(cache.name)
          .update({'description': ""});
    }
  }

  ///
  /// Update cache codes- unused
  ///
  void writeCompletionCodes() async {
    for (Cache cache in this.caches) {
      String s = generateRandomQrCode();
      print(s);
      await FirebaseFirestore.instance
          .collection('caches')
          .doc(cache.name)
          .update({'completionCode': generateRandomQrCode()});
    }
  }

  ///
  /// QR Code Generation-Unused
  ///
  List<String> alreadyUsed = [];

  String generateRandomQrCode() {
    String alphanum = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    String randomString = '';
    for (int i = 0; i < 4; i++) {
      int randNumber = new Random().nextInt(alphanum.length);
      randomString += alphanum.substring(randNumber, randNumber + 1);
    }
    if (!alreadyUsed.contains(randomString)) {
      alreadyUsed.add(randomString);
      return 'LMHSGEO-' + randomString;
    } else {
      return generateRandomQrCode();
    }
  }
}
