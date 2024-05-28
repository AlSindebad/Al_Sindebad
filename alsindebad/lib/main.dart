import 'package:alsindebad/views/screens/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:alsindebad/views/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/views/screens/palce_info.dart';
import 'package:alsindebad/views/screens/emergancy_call.dart';
import 'package:alsindebad/views/screens/signin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'views/screens/signup.dart';
import 'views/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDzWwJcxToQqCQJHwWQTUt9oOz63VltWgA",
        databaseURL: "https://sindebad-5d3de.firebaseio.com", // تأكد من استخدام الرابط الصحيح لقاعدة البيانات
        projectId: "sindebad-5d3de",
        storageBucket: "sindebad-5d3de.appspot.com", // أضف هذا السطر
        messagingSenderId: "987560365634",
        appId: "1:987560365634:web:abcd1234efgh5678", // تأكد من أن لديك appId الصحيح
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Arabic
      ],
      home: SignIn(title: 'Sign In'),
      routes: {
        '/Home': (context) => Home(),
        '/SignIn': (context) => SignIn(title: 'Sign In'),
        '/SignUp': (context) => SignUp(title: 'Sign Up'),
        '/ProfileScreen': (context) => ProfileScreen(),
      },
    );
  }
}
