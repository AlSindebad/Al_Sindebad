import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/largButton.dart';
import '../widgets/signup.dart';

class SignUp extends StatelessWidget {
  final String title;

  const SignUp({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signIn,
                      style: TextStyle(color: Color(0xFF112466) ,fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your onPressed callback for "Sign Up"
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
                      style: TextStyle(color: Color(0xFF112466) ,fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SignUpForm(context: context),
              SizedBox(height: 20),
              LargButton(
                text: AppLocalizations.of(context)!.signup,
                onPressed: () {
                  // Add your onPressed callback for the custom button
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
