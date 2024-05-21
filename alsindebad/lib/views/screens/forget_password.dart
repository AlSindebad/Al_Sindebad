import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../viewmodel/pass_viewmodel.dart';
import '../widgets/app_bar_with_just_arrow.dart';
import '../widgets/forget_password.dart';
import '../widgets/mediumButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: CustomAppBarNavigateJustBack(title: localizations.forgetPasswordTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              localizations.forgetPasswordDescription,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            ForgetPasswordForm(formKey: formKey, emailController: emailController),
            SizedBox(height: 80),
            CustomOutlinedButton(
              text: localizations.resetPasswordButton,
              onPressed: () => resetPassword(context, formKey, emailController),
            ),
          ],
        ),
      ),
    );
  }
}
