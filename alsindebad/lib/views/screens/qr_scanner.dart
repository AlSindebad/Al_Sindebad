import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../viewmodels/qr_scanner_view_model.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class QRScanner extends StatelessWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization=AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => QRScannerViewModel(),
      child: Scaffold(
        appBar: CustomAppBarNavigateBack(title:localization!.qrCode),
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
