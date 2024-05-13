import 'package:alsindebad/views/screens/palce_info.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../widgets/appBar.dart';
import '../widgets/app_bar_with_navigate_back.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  bool _scanned = false;

  void _onQRViewCreated(QRViewController controller) {
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
          // After navigation is complete, dispose of the controller to stop scanning
          _controller.dispose();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNavigateBack(title: 'QR Scanner'),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
