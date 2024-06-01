import 'package:flutter/material.dart';
import '../widgets/tab_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  _EmergencyServiceCard(
                    image: 'assets/images/police-car.png',
                    serviceName: 'Police',
                    phoneNumber: '100',
                  ),

                  _EmergencyServiceCard(
                    image: 'assets/images/call.png',
                    serviceName: 'Civil Defense',
                    phoneNumber: '102',
                  ),
                  _EmergencyServiceCard(
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

class _EmergencyServiceCard extends StatelessWidget {
  final String image;
  final String serviceName;
  final String phoneNumber;

  const _EmergencyServiceCard({
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Call $serviceName'),
          content: Text('Do you want to call $serviceName now?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _callEmergencyService(phoneNumber);
                Navigator.of(context).pop();
              },
              child: Text('Call'),
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



