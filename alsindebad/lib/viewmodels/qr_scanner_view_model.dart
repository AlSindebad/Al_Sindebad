import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../views/screens/place_info.dart';

class QRScannerViewModel extends ChangeNotifier {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  bool _scanned = false;

  QRViewController get controller => _controller;

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    _controller = controller;
    _controller.scannedDataStream.listen((scanData) {
      if (!_scanned) {
        _scanned = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceInfo(id: scanData.code!, googleMapsUrl: ''),
          ),
        ).then((_) {
          _controller.dispose();
        });
      }
    });
  }

  void disposeController() {
    _controller.dispose();
  }
}
