import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignInViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signIn(String email, String password) async {
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


      notifyListeners();
      return null; // Returning null means success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return 'An error occurred: ${e.message}';
    } catch (e) {
      print('Sign in error: $e');
      return 'An error occurred: $e';
    }
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
      bool nameIsEmpty = userCredential.additionalUserInfo!.profile?['name'] == null;
      String? country = userCredential.additionalUserInfo!.profile?['country'];
      country = country ?? 'Choose'; // Set default country to 'USA'

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'id':userCredential.user!.uid,
        'email': userCredential.user!.email,
        'signInMethod': 'Google',
        'name': nameIsEmpty ? 'Anonymous' : userCredential.additionalUserInfo!.profile?['name'],
        'country': country,
      }, SetOptions(merge: true));


      notifyListeners();
      return null;
    } catch (e) {
      print('Google sign in error: $e');
      return 'An error occurred: $e';
    }
  }
}
