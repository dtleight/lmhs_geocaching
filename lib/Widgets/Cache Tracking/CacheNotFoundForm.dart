import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../Objects/Cache.dart';

final myController = TextEditingController();

class CacheNotFoundForm extends StatelessWidget {
  final Cache cache;

  CacheNotFoundForm(this.cache);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Text(
          "What seems to be the issue?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        OptionsNotFound(cache),
      ]),
    );
  }
}

enum ErrorType { QrNotWork, NotFound, Other }

class OptionsNotFound extends StatefulWidget {
  final Cache cache;

  OptionsNotFound(this.cache);

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
              onPressed: () async {
                await FlutterEmailSender.send(Email(
                  subject: subject +
                      " (Cache " +
                      widget.cache.cacheID.toString() +
                      ")",
                  body: myController.text.toString(),
                  recipients: ['lmthistoryapps@gmail.com'],
                  isHTML: false,
                ));
              }),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            splashColor: Colors.blueGrey,
            child: const Text('Clear'),
            onPressed: () => setState(() {
              // Reset
              errorType = ErrorType.values[0];
              myController.clear();
            }),
          ),
        ),
      ],
    );
  }
}
