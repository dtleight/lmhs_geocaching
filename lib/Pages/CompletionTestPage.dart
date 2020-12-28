/**
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;


import '../Objects/Cache.dart';
import '../Singletons/Account.dart';
import 'CacheNotFoundPage.dart';

class CompletionTestPage extends StatefulWidget
{
  Cache cache;
  CompletionTestPage(Cache cache)
  {
    this.cache = cache;
  }
  @override
  _CompletionTestState createState() => new _CompletionTestState(cache);
}

class _CompletionTestState extends State<CompletionTestPage> {
  String barcode = "";
  Cache cache;
  _CompletionTestState(Cache cache)
  {
    this.cache = cache;
  }
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
      if(barcode == cache.completionCode)
        {
          print("Cache code found");
          new Account().onCacheCompletion(cache);
        }
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
**/