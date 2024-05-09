import 'package:flutter/material.dart';
import 'views/widgets/categories_view.dart';
import 'views/widgets/search_component.dart';
import 'views/widgets/signup.dart';
import 'views/widgets/signin.dart';
import 'views/widgets/forget_password.dart';
import 'views/widgets/new_password.dart';
import 'views/widgets/card_events.dart';
import 'views/widgets/appBar.dart';
import 'views/widgets/tabBar.dart';
import 'views/widgets/cardNotification.dart';
import 'views/widgets/largButton.dart';
import 'views/widgets/smallButton.dart';
import 'views/widgets/mediumButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      home: MyHomePage(),
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
