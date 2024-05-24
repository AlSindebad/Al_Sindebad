import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signIn(String email, String password) async {
    try {
      // Check if email exists in Firestore
      final QuerySnapshot result = await _firestore.collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = result.docs;
      if (documents.isEmpty) {
        return 'No account found for that email. Please sign up first.';
      }

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore if not already present
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'signInMethod': 'Email',
      }, SetOptions(merge: true)); // Use merge to avoid overwriting

      // Notify listeners that sign in was successful
      notifyListeners();
      return null; // Returning null means success
    } catch (e) {
      print('Sign in error: $e');
      return e.toString(); // Returning the error message
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

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'signInMethod': 'Google',
      }, SetOptions(merge: true)); // Use merge to avoid overwriting

      // Notify listeners that sign in was successful
      notifyListeners();
      return null; // Returning null means success
    } catch (e) {
      print('Google sign in error: $e');
      return e.toString(); // Returning the error message
    }
  }
}
