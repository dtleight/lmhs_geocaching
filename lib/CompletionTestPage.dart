import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'CacheNotFoundPage.dart';

class CompletionTestPage extends StatefulWidget
{
  @override
  _CompletionTestState createState() => new _CompletionTestState();
}

class _CompletionTestState extends State<CompletionTestPage> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
                child: RaisedButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  child: const Text('Cache Not Found'),
                  onPressed: () {Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new CacheNotFoundPage()));},
                ),
                ),
              ],
          ),
          ),
        );
  }

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      //String barcode = (await BarcodeScanner.scan()) as String;
      setState(() => this.barcode = barcode);
    }
    on Exception
    {
      //Do nothing
      print('k');
    }
  }
}

/**
import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
    **/