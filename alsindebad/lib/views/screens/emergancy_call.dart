import 'package:flutter/material.dart';
import '../widgets/tab_bar.dart';
import 'package:alsindebad/viewmodels/emergency_call_view_model.dart';




class EmergencyCall extends StatelessWidget {
  const EmergencyCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Calls"), leading: BackButton()),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmergencyServiceCard(
                    image: 'assets/images/police-car.png',
                    serviceName: 'Police',
                    phoneNumber: '100',
                  ),

                  EmergencyServiceCard(
                    image: 'assets/images/call.png',
                    serviceName: 'Civil Defense',
                    phoneNumber: '102',
                  ),
                  EmergencyServiceCard(
                    image: 'assets/images/phone-call.png',
                    serviceName: 'Ambulance',
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



