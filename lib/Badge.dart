import 'dart:io';

import 'package:image/image.dart';

class Badge
{
  String name;
  String imageSRC;
  bool isObtained;
  String description;
  DateTime unlockDate;

  int _cachesCollected;
  int _cachesNeeded;


  //Constructor
  Badge(String name, String src, int need) {
    this.name = name;
    this.imageSRC = src;
    isObtained = true;

    _cachesCollected = 0;
    _cachesNeeded = need;
  }

  getName() {
    return name;
  }

  getImage() {
    print("got not"); // Do not question my debugging tactics
    File file = new File(imageSRC);
    print("got milk");
    List<int> bytes = file.readAsBytesSync();
    //TODO: Fix error caused by the above line - doens't like the file paths given to it
    print("got here");
    Image img = decodeJpg(bytes);
    print("got there");
    if(isObtained)
      {
        return img.getBytes();
      }
    return grayscale(img).getBytes();
  }

  cacheFound() {
    _cachesCollected++;
    if(_cachesCollected == _cachesNeeded) {
      isObtained = true;
    }
  }
}