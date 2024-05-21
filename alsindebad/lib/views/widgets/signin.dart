import 'package:flutter/material.dart';
import 'package:alsindebad/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Getter to expose the form key
  GlobalKey<FormState> get formKey => _SignInFormState._formKey;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     final localizations = AppLocalizations.of(context);
     if (localizations == null) {
       return Center(
         child: CircularProgressIndicator(),
      );
     }

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
                  controller: widget.emailController,
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
                  controller: widget.passwordController,
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
          ],
        ),
      ),
    );
  }
}
