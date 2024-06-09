import 'package:flutter/material.dart';
import 'package:alsindebad/viewmodels/emergency_call_view_model.dart';
import '../widgets/app_bar_with_just_arrow.dart';
import '../widgets/tab_Bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:alsindebad/viewmodels/emergency_call_view_model.dart';


class EmergencyCall extends StatelessWidget {
  const EmergencyCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBarNavigateJustBack(
        title: localizations!.emergencyCalls,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmergencyServiceCard(
                    image: 'assets/images/police-car.png',
                    serviceName: localizations.police,
                    phoneNumber: '100',
                  ),

                  EmergencyServiceCard(
                    image: 'assets/images/call.png',
                    serviceName: localizations.civilDefense,
                    phoneNumber: '102',
                  ),
                  EmergencyServiceCard(
                    image: 'assets/images/phone-call.png',
                    serviceName: localizations.ambulance,
                    phoneNumber: '101',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: NavigationExample(),
          ),
        ],
      ),
    );
  }
}



