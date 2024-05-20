import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../viewmodel/sign_up_view_model.dart';
import '../widgets/largButton.dart';
import '../widgets/signup.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpViewModel _viewModel = SignUpViewModel();
  String _errorMessage = '';

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
                      // Navigate to sign-in screen
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signIn,
                      style: TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Do nothing, already on sign-up screen
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
                      style: TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SignUpForm(),
              SizedBox(height: 20),
              SizedBox(height: 10),
              if (_errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


