import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

   void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


Future<void> resetPassword(BuildContext context, GlobalKey<FormState> formKey, TextEditingController emailController) async {
  final localizations = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );

  if (formKey.currentState?.validate() ?? false) {
    String email = emailController.text.trim();

    bool emailExists = await checkIfEmailExists(email);

    if (emailExists) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Navigator.of(context).pop();
        showSnackBar(context, localizations.resetEmailSent);
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        showSnackBar(context, localizations.failedToSendResetEmail);
      } catch (e) {
        Navigator.of(context).pop();
        showSnackBar(context, localizations.error);
      }
    } else {
      Navigator.of(context).pop();
     showSnackBar(context, localizations.noUserFoundForEmail);
    }
  } else {
    Navigator.of(context).pop();
    showSnackBar(context, localizations.enterValidEmail);
  }
}

Future<bool> checkIfEmailExists(String email) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();
  return querySnapshot.docs.isNotEmpty;
}
