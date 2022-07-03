import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';

class QRCodeReader extends StatefulWidget {
  Cache cache;

  QRCodeReader(Cache cache) {
    this.cache = cache;
  }

  @override
  State<StatefulWidget> createState() {
    return QRCodeReaderState(cache);
  }
}

class QRCodeReaderState extends State<QRCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  var controller;
  Cache cache;

  QRCodeReaderState(Cache cache) {
    this.cache = cache;
  }

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      if (event.code.toString() == cache.completionCode) {
        print("Cache code found");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Cache found")),
        );
        new Account().onCacheCompletion(cache);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder(
            future: loadCameraPermission(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return (snapshot.data != null && snapshot.data)
                  ? QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )
                  : CircularProgressIndicator();
            },
          ),
          flex: 4,
        ),
      ],
    );
  }

  Future<bool> loadCameraPermission() async {
    return getPermission().isGranted;
  }

  Future<PermissionStatus> getPermission() async {
    var status = await Permission.camera.status;
    print(status);
    if (status == PermissionStatus.denied) {
      print("Denied");
      status = await Permission.camera.request();
      print("Status");
    }
    return status;
  }
}