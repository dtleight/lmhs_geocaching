import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmhsgeocaching/Pages/CachePage.dart';
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
  bool cacheFound = false;
  bool qrScannerEnabled = true;
  TextEditingController overrideController = TextEditingController();

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((result) {
      testCode(result.code.toString());
    });
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: qrScannerEnabled
              ? FutureBuilder(
                  future: loadCameraPermission(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return (snapshot.data != null && snapshot.data)
                        ? QRView(
                            key: GlobalKey(debugLabel: 'QR'),
                            onQRViewCreated: _onQRViewCreated,
                          )
                        : CircularProgressIndicator();
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: overrideController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:
                                "Enter the 4-character code on the cache.",
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              testCode("LMHSGEO-" +
                                  overrideController.text.toUpperCase());
                            },
                            child: Text("Check value")),
                      ],
                    ),
                  ),
                ),
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              setState(() => qrScannerEnabled = !qrScannerEnabled);
            },
            child: Text(qrScannerEnabled ? "Text Override" : "QR Scanner"),
          ),
        ),
      ],
    );
  }

  void testCode(String code) {
    if (!cacheFound && code == widget.cache.completionCode) {
      cacheFound = true;
      print("Cache code found");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Cache found!"),
          content: Text("Congratulations, go find more caches."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CachePage(),
                ),
              ),
            )
          ],
        ),
      );

      new Account().onCacheCompletion(widget.cache);
    }
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
