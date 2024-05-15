import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../viewmodel/qr_scanner_view_model.dart';
import '../widgets/app_bar_with_navigate_back.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QRScannerViewModel(),
      child: Scaffold(
        appBar: CustomAppBarNavigateBack(title: 'QR Scanner'),
        body: Consumer<QRScannerViewModel>(
          builder: (context, viewModel, child) {
            return QRView(
              key: viewModel.qrKey,
              onQRViewCreated: (controller) => viewModel.onQRViewCreated(controller, context),
            );
          },
        ),
      ),
    );
  }
}
