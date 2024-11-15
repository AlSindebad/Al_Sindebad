
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/sign_in.dart';
import 'sign_up.dart';
import '../../viewmodels/sign_in_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'forget_password.dart';

class SignIn extends StatefulWidget {
  final String title;
  const SignIn({Key? key, required this.title}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInViewModel _signInViewModel = SignInViewModel();
  String? _errorMessage = '';
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isUserSignedIn = prefs.getBool('isUserSignedIn') ?? false;
    final bool rememberMe = prefs.getBool('rememberMe') ?? false;

    if (isUserSignedIn) {
      Navigator.pushReplacementNamed(context, '/Home');
    } else if (rememberMe) {
      Navigator.pushReplacementNamed(context, '/Home');
    }
  }


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
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)?.signIn ?? 'Sign In',
                      style: TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
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
              SignInForm(
                onSignIn: (email, password, rememberMe) async {
                  setState(() {
                    _errorMessage = null;
                  });

                  final errorMessage = await _signInViewModel.signIn(email, password, rememberMe);
                  setState(() {
                    _errorMessage = errorMessage;
                  });

                  if (errorMessage == null) {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isUserSignedIn', true);
                    await prefs.setBool('rememberMe', rememberMe);

                    Navigator.pushReplacementNamed(context, '/Home');
                  }
                },
                rememberMe: _rememberMe,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)?.rememberMe ?? 'Remember Me',
                    style: TextStyle(color: Color(0xFF112466), fontSize: 16.0),
                  ),
                ],
              ),
              if (_errorMessage != null)
                Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
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
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('rememberMe', _rememberMe);

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
