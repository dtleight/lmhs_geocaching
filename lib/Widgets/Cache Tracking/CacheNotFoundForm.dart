import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../../Objects/Cache.dart';

final myController = TextEditingController();

class CacheNotFoundForm extends StatelessWidget {
  final Cache cache;

  CacheNotFoundForm(this.cache);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "What seems to be the issue?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        OptionsNotFound(cache),
      ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
          TextField(
            controller: (myController),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Please explain your issue in more detail.",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Spacer(flex: 2),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text(
                        'Send Message',
                        style: TextStyle(color: Colors.white),
                      ),
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
                Spacer(),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => setState(() {
                      // Reset
                      errorType = ErrorType.values[0];
                      myController.clear();
                    }),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
