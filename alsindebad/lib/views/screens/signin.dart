import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/signin.dart';
import '../../viewmodel/signin_viewmodel.dart';
import 'signup.dart';
import 'forget_password.dart';

class SignIn extends StatefulWidget {
  final String title;
  const SignIn({Key? key, required this.title}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInViewModel _signInViewModel = SignInViewModel();
  String? _errorMessage='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Do nothing, already on sign-in screen
                    },
                    child: Text(
                      AppLocalizations.of(context)?.signIn ?? 'Sign In',
                      style: TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp(title: 'Sign Up')),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)?.signup ?? 'Sign Up',
                      style: TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                ],
              ),

              SignInForm(),

              if (_errorMessage != null) ...[
                Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] ?? const [],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)?.orSignInWith ?? 'or sign in with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      size: 30,
                    ),
                    color: Color(0xFF112466),
                    onPressed: () async {
                      setState(() {
                        _errorMessage = null;
                      });

                      final errorMessage = await _signInViewModel.signInWithGoogle();
                      setState(() {
                        _errorMessage = errorMessage;
                      });

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, '/Home');
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)?.forgetYourPassword ?? 'Forget your password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
