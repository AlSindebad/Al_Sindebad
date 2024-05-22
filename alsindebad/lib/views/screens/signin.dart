import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/largButton.dart';
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
  final SignInForm _signInForm = SignInForm();
  bool _isLoading = false;
  String? _errorMessage;

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
              // Add buttons for navigation at the top
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Do nothing, already on sign-in screen
                    },
                    child: Text(
                      AppLocalizations.of(context)?.signIn ?? 'Sign In',
                      style:
                          TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUp(title: 'Sign Up')),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)?.signup ?? 'Sign Up',
                      style:
                          TextStyle(color: Color(0xFF112466), fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              _signInForm,
              SizedBox(height: 25.0),
              if (_isLoading) ...[
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 25.0),
              ],
              if (_errorMessage != null) ...[
                Center(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 25.0),
              ],
              // Sign In Button
              Center(
                child: LargButton(
                  text: AppLocalizations.of(context)?.signIn ?? 'Sign in',
                  onPressed: () async {
                    if (_signInForm.formKey.currentState?.validate() ?? false) {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      final errorMessage = await _signInViewModel.signIn(
                        _signInForm.emailController.text,
                        _signInForm.passwordController.text,
                      );

                      setState(() {
                        _isLoading = false;
                        _errorMessage = errorMessage;
                      });

                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      }
                    }
                  },
                  backgroundColor: Color(0xFF112466),
                  textColor: Colors.white,
                  borderRadius: 5.0,
                  padding: 10.0,
                  fontSize: 16.0,
                  width: 200.0, // Set a specific width for the button
                  margin: 0.0, // Remove margin to centralize the button
                ),
              ),
              SizedBox(height: 25.0),
              // Social Sign-In Buttons
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
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      final errorMessage =
                          await _signInViewModel.signInWithGoogle();

                      setState(() {
                        _isLoading = false;
                        _errorMessage = errorMessage;
                      });

                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      }
                    },
                  ),
                  SizedBox(width: 20.0),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                    ),
                    color: Color(0xFF112466),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });

                      final errorMessage =
                          await _signInViewModel.signInWithFacebook();

                      setState(() {
                        _isLoading = false;
                        _errorMessage = errorMessage;
                      });

                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      }
                    },
                  ),
                  SizedBox(width: 20.0),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      size: 30,
                    ),
                    color: Color(0xFF112466),
                    onPressed: () {
                      // Handle Twitter sign in
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Forget Password Text
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to forget password screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)?.forgetYourPassword ??
                        'Forget your password',
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
