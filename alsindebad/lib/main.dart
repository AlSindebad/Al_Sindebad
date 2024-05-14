
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alsindebad/views/screens/palce_info.dart';
import 'package:alsindebad/views/screens/emergency-calls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDzWwJcxToQqCQJHwWQTUt9oOz63VltWgA",
        databaseURL: "https://console.firebase.google.com/project/sindebad-5d3de/firestore/databases/-default-/data/~2F",
        projectId: "sindebad-5d3de",
        messagingSenderId: "987560365634",
        appId: "sindebad-5d3de",
      ),
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MyApp());
}

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Example',
      //home: PlaceInfo(id:'MWCc07LdnZhGg4NITRkL', googleMapsUrl:''),
      home:EmergencyCall(),
      debugShowCheckedModeBanner: false,
    );
   }
  }

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthenticationScreen()),
            );
          },
          child: Text('Authenticate'),
        ),
      ),
    );
  }
}

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Screen'),
      ),
      body: Center(
        child: Text('Authentication Screen'),
      ),
    );
  }
}

