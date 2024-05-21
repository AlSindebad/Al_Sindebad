import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/largButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/signin.dart';
import '../../viewmodel/signin_viewmodel.dart';
import 'signup.dart';


class SignIn extends StatelessWidget {
  final String title;
  const SignIn({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create an instance of SignInViewModel
    final signInViewModel = SignInViewModel();
    final signInForm = SignInForm(); // Create an instance of SignInForm

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
              SizedBox(height: 50.0), // Add some space after the buttons
              signInForm, // Use the instance of SignInForm here
              SizedBox(height: 25.0),
              // Sign In Button
              Center(
                child: LargButton(
                  text: AppLocalizations.of(context)?.signIn ?? 'Sign in',
                  onPressed: () async {
                    if (signInForm.formKey.currentState?.validate() ?? false) {
                      // Handle sign in action using SignInViewModel
                      final errorMessage = await signInViewModel.signIn(
                        signInForm.emailController.text,
                        signInForm.passwordController.text,
                      );
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      } else {
                        // Show an error message if sign in fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign in failed! $errorMessage')),
                        );
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
              SizedBox(height: 30.0),
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
                      // Handle Google sign in
                      final errorMessage = await signInViewModel.signInWithGoogle();
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      } else {
                        // Show an error message if sign in fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google sign in failed! $errorMessage')),
                        );
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
                      // Handle Facebook sign in
                      final errorMessage = await signInViewModel.signInWithFacebook();
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, '/Home');
                      } else {
                        // Show an error message if sign in fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Facebook sign in failed! $errorMessage')),
                        );
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
                    // Handle forget password action
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
