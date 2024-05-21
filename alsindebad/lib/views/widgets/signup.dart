import 'package:alsindebad/utils/validators.dart';
import 'package:alsindebad/viewmodel/sign_up_view_model.dart';
import 'package:alsindebad/views/widgets/largButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../screens/home.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    countryController.dispose();
    super.dispose();
  }

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

   Future<void>register(AppLocalizations localizations) async {
    String hashedPassword = hashPassword(passwordController.text);
    String hashedConfirmPassword = hashPassword(confirmPasswordController.text);

    String res = await SignUpViewModel().signup(
      name: nameController.text,
      email: emailController.text,
      country: countryController.text,
      password: hashedPassword,
      confirmPassword: hashedConfirmPassword,
    );

      if(res=="Successful") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else if(res=="uniqueEmailError") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(localizations.uniqueEmailError)),
        );
      }

  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    List<String> countries = [
      localizations.chosse,
      localizations.usa,
      localizations.canada,
      localizations.palestine,
      localizations.australia,
      localizations.germany,
      localizations.france,
      localizations.spain,
      localizations.italy,
      localizations.egypt,
      localizations.japan
    ];
    var selectedCountry = countries.first;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: localizations.name,
                    hintText: localizations.name,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateName(value, localizations),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
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
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedCountry, // Set the initial value
                  decoration: InputDecoration(
                    labelText: localizations.country,
                    hintText: localizations.country,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      countryController.text = newValue!;
                    });
                  },
                  items: countries.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
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
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: localizations.confirmPass,
                    hintText: localizations.confirmPass,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (hashPassword(value!) != hashPassword(passwordController.text)) {
                      return localizations.confirmPasswordValidationError;
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 20.0),
            LargButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  register(localizations);

                }
              },
              text: localizations.signup,
            ),
          ],
        ),
      ),
    );
  }
}
