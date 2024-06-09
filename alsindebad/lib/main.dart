// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'views/screens/home.dart';
// import 'views/screens/sign_in.dart';
// import 'views/screens/sign_up.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   try {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(
//         options: FirebaseOptions(
//           apiKey: "AIzaSyDzWwJcxToQqCQJHwWQTUt9oOz63VltWgA",
//           databaseURL: "https://sindebad-5d3de.firebaseio.com",
//           projectId: "sindebad-5d3de",
//           storageBucket: "sindebad-5d3de.appspot.com",
//           messagingSenderId: "987560365634",
//           appId: "1:987560365634:web:abcd1234efgh5678",
//         ),
//       );
//       print("Firebase initialized successfully");
//     } else {
//       print("Firebase already initialized");
//     }
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         const Locale('en', ''),
//         const Locale('ar', ''),
//       ],
//       home: SignIn(title: 'Sign In'),
//       routes: {
//        // '/Home': (context) => Home(),
//         '/SignIn': (context) => SignIn(title: 'Sign In'),
//         '/SignUp': (context) => SignUp(title: 'Sign Up'),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'views/screens/home.dart';
import 'views/screens/sign_in.dart';
import 'views/screens/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyDzWwJcxToQqCQJHwWQTUt9oOz63VltWgA",
          databaseURL: "https://sindebad-5d3de.firebaseio.com",
          projectId: "sindebad-5d3de",
          storageBucket: "sindebad-5d3de.appspot.com",
          messagingSenderId: "987560365634",
          appId: "1:987560365634:web:abcd1234efgh5678",
        ),
      );
      print("Firebase initialized successfully");
    } else {
      print("Firebase already initialized");
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ar', ''),
      ],
      home: SignIn(title: 'Sign In'),
      routes: {
      '/Home': (context) => Home(),
        '/SignIn': (context) => SignIn(title: 'Sign In'),
        '/SignUp': (context) => SignUp(title: 'Sign Up'),
      },
    );
  }
}
