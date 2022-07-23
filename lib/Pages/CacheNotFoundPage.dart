import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../Objects/Cache.dart';

final myController = TextEditingController();

class CacheNotFoundPage extends StatelessWidget
{
  final Cache cache;

  CacheNotFoundPage(this.cache);

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
enum ErrorType { QrNotWork, NotFound, Other }

class OptionsNotFound extends StatefulWidget {
  @override
  OptionsNotFoundState createState() => OptionsNotFoundState();
}

class OptionsNotFoundState extends State<OptionsNotFound> {
  late ErrorType errorType;
  late String subject;

  @override
  void initState() {
    super.initState();
    errorType = ErrorType.values[0];
    subject = "QR Code Does Not Work";
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text("QR Code Does Not Work"),
          leading: Radio(
            value: ErrorType.QrNotWork,
            groupValue: errorType,
            onChanged: (ErrorType? value) {
              setState(() {
                errorType = value!;
                subject = "QR Code Does Not Work";
              });
            },
          ),
        ),
        ListTile(
          title: const Text("Cache Not Found"),
          leading: Radio(
            value: ErrorType.NotFound,
            groupValue: errorType,
            onChanged: (ErrorType? value) {
              setState(() {
                errorType = value!;
                subject = "Cache not found";
              });
            },
          ),
        ),
        ListTile(
          title: const Text("Other"),

          leading: Radio(
            value: ErrorType.Other,
            groupValue: errorType,
            onChanged: (ErrorType? value) {
              setState(() {
                errorType = value!;
                subject = "Other";
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
                subject = subject.toString();
                String body = myController.text.toString();
                Email();
                FlutterEmailSender.send(Email(
                  subject: subject,
                  body: body,
                  recipients: ['dhkreidler@gmail.com', 'mjmagee991@gmail.com'],//temporary
                  isHTML: false,
                ));
                //Reset
                errorType = ErrorType.values[0];
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
                // Reset
                errorType = ErrorType.values[0];
                myController.clear();
              });}
          ),
        ),
      ],
    );
  }
}
