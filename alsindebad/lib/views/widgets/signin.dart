import 'package:flutter/material.dart';
import 'package:alsindebad/utils/validators.dart';
import 'package:alsindebad/viewmodel/signin_viewmodel.dart';
import '../widgets/largButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  static final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final SignInViewModel _viewModel = SignInViewModel();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn(BuildContext context, AppLocalizations localizations) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Call view model to sign in
      final errorMessage = await _viewModel.signIn(
        emailController.text,
        passwordController.text,
      );

      if (errorMessage == null) {
        Navigator.pushReplacementNamed(context, '/Home');
      } else {
        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.massageError)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Email Input
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Add space between fields
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Changed border color to match password input
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: localizations.email,
                    hintText: localizations.email,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateEmail(value, localizations),
                ),
              ),
            ),
            // Password Input
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Add space below password input
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: localizations.pass,
                    hintText: localizations.pass,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => Validators.validatePassword(value, localizations),
                ),
              ),
            ),
            // Sign-In Button
            Padding(
              padding: const EdgeInsets.only(top: 20.0), // Add space above the button
              child: LargButton(
                text: localizations.signIn,
                onPressed: () async {
                  await signIn(context, localizations);
                },
                backgroundColor: Color(0xFF112466),
                textColor: Colors.white,
                borderRadius: 5.0,
                padding: 10.0,
                fontSize: 16.0,
                width: 290.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
