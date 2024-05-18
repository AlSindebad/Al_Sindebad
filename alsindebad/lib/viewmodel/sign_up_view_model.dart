import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/validators.dart';

class SignUpViewModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String country = countryController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    errorMessage = null;

    String? nameError = Validators.validateName(name);
    String? emailError = Validators.validateEmail(email);
    String? passwordError = Validators.validatePassword(password);

    if (nameError != null || emailError != null || passwordError != null || password != confirmPassword) {
      errorMessage = nameError ?? emailError ?? passwordError ?? 'Passwords do not match';
      notifyListeners();
      return;
    }

    String? uniqueEmailError = await Validators.validateUniqueEmail(email, firestore);
    if (uniqueEmailError != null) {
      errorMessage = uniqueEmailError;
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      await firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'country': country,
        'createdAt': FieldValue.serverTimestamp(),
      });


    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } finally {
      // Stop loading
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    countryController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
