// import 'package:flutter/material.dart';
// import 'package:alsindebad/views/screens/home.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:alsindebad/views/screens/palce_info.dart';
// import 'package:alsindebad/views/screens/emergancy_call.dart';
// import 'package:alsindebad/views/screens/signin.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'views/screens/signup.dart';
//
//
//  void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//         apiKey: "AIzaSyDzWwJcxToQqCQJHwWQTUt9oOz63VltWgA",
//         databaseURL: "https://console.firebase.google.com/project/sindebad-5d3de/firestore/databases/-default-/data/~2F",
//         projectId: "sindebad-5d3de",
//         messagingSenderId: "987560365634",
//         appId: "sindebad-5d3de",
//       ),
//     );
//     print("Firebase initialized successfully");
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       title: 'Firebase Auth Example',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SignIn(title: 'Sign in'),
//         '/Home': (context) => Home(),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Auth Example'),
//       ),
//       // body: Center(
//       //   child: ElevatedButton(
//       //     onPressed: () {
//       //       Navigator.push(
//       //         context,
//       //         MaterialPageRoute(builder: (context) => AuthenticationScreen()),
//       //       );
//       //     },
//       //     child: Text('Authenticate'),
//       //   ),
//       // ),
//
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:alsindebad/views/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'views/screens/signup.dart';

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
      title: 'Al_Sindebad',
      debugShowCheckedModeBanner: false,
      home: SignUp(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Spanish
        // Add more supported locales here
      ],
    );
  }
}

