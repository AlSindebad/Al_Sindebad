import 'package:flutter/material.dart';
import 'views/widgets/categories_view.dart';
import 'views/widgets/search_component.dart';
import 'views/widgets/signup.dart';
import 'views/widgets/signin.dart';
import 'views/widgets/forget_password.dart';
import 'views/widgets/new_password.dart';
import 'views/widgets/card_events.dart';

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
      //home:EventC}ard(eventName: 'Example Event'),
   // home: Scaffold(
   //     body: Center(
   //       child: EventCard(eventName: 'Event name' , imageUrl:''),
   //   ),
   // ),
    );
  }
}
