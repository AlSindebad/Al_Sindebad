import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmergencyServiceCard extends StatelessWidget {
  final String image;
  final String serviceName;
  final String phoneNumber;

  const EmergencyServiceCard({
    required this.image,
    required this.serviceName,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showCallDialog(context, serviceName, phoneNumber);
      },
      child: Container(
        height: 90,
        child: Image.asset(image),
      ),
    );
  }

  void _showCallDialog(BuildContext context, String serviceName, String phoneNumber) {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${localizations?.call} $serviceName'),
          content: Text(localizations?.doYouWantToCall ?? 'Do you want to call?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations?.cancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                _callEmergencyService(phoneNumber);
                Navigator.of(context).pop();
              },
              child: Text(localizations?.call ?? 'Call'),
            ),
          ],
        );
      },
    );
  }
  void _callEmergencyService(String phoneNumber) {
    final url = 'tel:$phoneNumber';
    launch(url);
  }
}
