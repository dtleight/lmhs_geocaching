import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'file:///C:/Users/dtlei/AndroidStudioProjects/lmhs_geocaching/lib/Pages/HomePage.dart';
import '../Singletons/Account.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../Utilities/main.dart';

String subject1;
String body;
final myController = TextEditingController();

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
          ]),
    );
    }
  }
enum optionWrong { QrNotWork, NotFound, Other }

class OptionsNotFound extends StatefulWidget {
  OptionsNotFound({Key key}) : super(key: key);

  @override
  _OptionsNotFoundState createState() => _OptionsNotFoundState();
}

class _OptionsNotFoundState extends State<OptionsNotFound> {
  optionWrong _option;

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
                subject1 = "QR Code Does Not Work";
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
                subject1 = "Cache not found";
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
                subject1 = "Other";
              });
            },
          ),
        ),
        SizedBox(
          height: 25,
        ),
        TextField(
          controller: (myController),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Please explain your issue in more detail.",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8.0),
          child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              child: const Text('Send Message'),
              onPressed: () {
                subject1 = subject1.toString();
                body = myController.text.toString();
                Email();
                FlutterEmailSender.send(mailer);
                _option = null;
                myController.clear();
                Phoenix.rebirth(context);
              }
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              child: const Text('Clear'),
              onPressed: () {setState(() {
                _option = null;
                myController.clear();
              });}
          ),
        ),
      ],
    );
  }
}
Email mailer  = Email(
  subject: subject1,
  body: body,
  recipients: ['dhkreidler@gmail.com'],//temporary
  isHTML: false,
);