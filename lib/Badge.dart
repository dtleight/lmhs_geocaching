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
    print("got not");
    File file = new File(imageSRC);
    print("got here");
    Image img = decodeImage(file.readAsBytesSync());
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