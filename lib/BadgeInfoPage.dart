import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lmhsgeocaching/BadgeInfoPage.dart';
import 'Badge.dart';
import 'BadgeLoader.dart';

class BadgeInfoPage extends StatelessWidget {


  static bool _obtained;
  static String _badgeName;
  static int _badgeID;
  static dynamic badgeImage;



  //Constructor
  BadgeInfoPage(Badge B){
    _obtained = B.isObtained;
    _badgeName = B.name;
    _badgeID = B.badgeID;
    badgeImage = B.getImage();
  }

  @override
  Widget build(BuildContext context)
  {
    //String _unlockDate = unlockDate.toString();
    return new Scaffold(
        appBar: AppBar (
          title: Text(_badgeName),
        ),
        body:
          SizedBox(
              width: 500,
              height: 200,
              child: badgeImage,
          )
           /* Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                [
                  InkWell(
                  child: CircleAvatar(
                  backgroundColor: Color(0xffFDCF09),
                  radius:90,                                                //badge image src
                    child: CircleAvatar(backgroundImage: AssetImage(imageSRC),radius: 85,)),
                  ),
            ]),*/
      );
  }
}
