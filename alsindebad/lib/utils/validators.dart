import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value) || !value.endsWith('.com')) {
      return 'Invalid email format. It must contain "@" and end with ".com"';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return 'Name must not contain numbers or special characters';
    }
    return null;
  }

  static Future<String?> validateUniqueEmail(String? email, FirebaseFirestore firestore) async {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final querySnapshot = await firestore.collection('users').where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      return 'Email is already in use';
    }
    return null;
  }
}
