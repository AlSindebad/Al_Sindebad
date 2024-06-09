import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SignInViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _saveLoginDataLocally(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<String?> signIn(String email, String password, bool rememberMe) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please enter email and password';
    }

    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final DocumentSnapshot userDoc = await _firestore.collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        return 'No account found for that email. Please sign up first.';
      }

      if (rememberMe) {
        await _saveLoginDataLocally(email, password);
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('rememberMe', true);
        });
      } else {
        await SharedPreferences.getInstance().then((prefs) {
          prefs.remove('rememberMe');
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'Email Or Password is Not Correct!';
    } catch (e) {
      return 'Email Or Password is Not Correct!';
    }
  }

  Future<String?> signInWithSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    if (email.isNotEmpty && password.isNotEmpty) {
      final errorMessage = await signIn(email, password, true);
      if (errorMessage == null) {
        final rememberMe = prefs.getBool('rememberMe') ?? false;
        if (rememberMe) {
          return null;
        }
      }
      return errorMessage;
    }

    final rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      return signIn(email, password, true);
    }
    return null;
  }

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return 'Google sign in aborted';
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'signInMethod': 'Google',
      }, SetOptions(merge: true));

      notifyListeners();
      return null;
    } catch (e) {
      print('Google sign in error: $e');
      return 'An error occurred: $e';
    }
  }
}
