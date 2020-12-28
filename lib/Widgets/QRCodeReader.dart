import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_qr_scanner/last_qr_scanner.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';

class QRCodeReader extends StatefulWidget
{
  Cache cache;
  QRCodeReader(Cache cache){this.cache = cache;}
  @override
  State<StatefulWidget> createState() {
    return QRCodeReaderState(cache);
  }
}
class QRCodeReaderState extends State<QRCodeReader>
{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  var controller;
  Cache cache;
  QRCodeReaderState(Cache cache){this.cache = cache;}
  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final channel = controller.channel;
    controller.init(qrKey);
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
          if(arguments.toString() == cache.completionCode)
          {
            print("Cache code found");
            new Account().onCacheCompletion(cache);
          }
          setState(() {
            qrText = arguments.toString();
          });
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: <Widget>[
        Expanded(
          child: LastQrScannerPreview(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          flex: 4,
        ),
      ],
    );
  }

}