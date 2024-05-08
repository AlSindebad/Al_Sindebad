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
import 'views/widgets/meduimButton.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //  home: CategoriesComponent(),
      //home:SignUpForm(),
      // home:SignInForm(),
      //  home:ForgetPasswordForm(),
      //home:NewPasswordForm(),
      //home:VerificationForm(),
      //home: AppBarApp(),
      // home: Cardnotification(),
      // home: LButton(),
      //home:MButton(),
      home: NavigationExample(),
     // home:SButton(),

      //home:EventCard(eventName: 'Example Event'),
    );
  }
}