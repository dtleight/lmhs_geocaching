import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:lmhsgeocaching/Singletons/Account.dart';

class QRCodeReader extends StatefulWidget {
  final Cache cache;

  QRCodeReader(this.cache);

  @override
  State<StatefulWidget> createState() => QRCodeReaderState();
}

class QRCodeReaderState extends State<QRCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((result) {
      if (result.code.toString() == widget.cache.completionCode) {
        print("Cache code found");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Cache found")),
        );
        new Account().onCacheCompletion(widget.cache);
      }
    });
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
