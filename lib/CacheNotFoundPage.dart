import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CacheNotFoundPage extends StatefulWidget
{
  @override
  _CacheNotFoundState createState() => new _CacheNotFoundState();
}

class _CacheNotFoundState extends State<CacheNotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cache Not Found Form"),),
      body: ListView(
        children: <Widget>[
          SizedBox(
          height: 25,
          ),
          Text("What seems to be the issue?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
          ),
          ),
          SizedBox(
            height: 25,
          ),
          OptionsNotFound(),
        ],
      ),
    );
  }
  }
enum optionWrong { QrNotWork, NotFound, Other }

class OptionsNotFound extends StatefulWidget {
  OptionsNotFound({Key key}) : super(key: key);

  @override
  _OptionsNotFoundState createState() => _OptionsNotFoundState();
}

class _OptionsNotFoundState extends State<OptionsNotFound>{
  optionWrong _option = optionWrong.QrNotWork;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: const Text("QR Code Does Not Work"),
            leading: Radio(
              value: optionWrong.QrNotWork,
              groupValue: _option,
              onChanged: (optionWrong value) {
                setState(() {
                  _option = value;
                });
            },
            ),
          ),
          ListTile(
            title: const Text("Cache Not Found"),
            leading: Radio(
              value: optionWrong.NotFound,
              groupValue: _option,
              onChanged: (optionWrong value) {
                setState(() {
                  _option = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text("Other"),
            leading: Radio(
              value: optionWrong.Other,
              groupValue: _option,
              onChanged: (optionWrong value) {
                setState(() {
                  _option = value;
                });
              },
            ),
          ),
              /**TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Issue",
                ),
              ),**/
        ],
    );
  }

}
