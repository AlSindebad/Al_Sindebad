import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if user exists in Firestore
      final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (!userDoc.exists) {
        return 'User not found'; // Return error if user does not exist
      }

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

      // Check if user exists in Firestore, create a new user document if not
      final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
          'createdAt': Timestamp.now(),
        });
      }

      // Notify listeners that sign in was successful
      notifyListeners();
      return null; // Returning null means success
    } catch (e) {
      print('Google sign in error: $e');
      return e.toString(); // Returning the error message
    }
  }

  Future<String?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        if (accessToken != null) {
          final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

          final UserCredential userCredential = await _auth.signInWithCredential(credential);

          // Check if user exists in Firestore, create a new user document if not
          final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
          if (!userDoc.exists) {
            await _firestore.collection('users').doc(userCredential.user!.uid).set({
              'email': userCredential.user!.email,
              'name': userCredential.user!.displayName,
              'createdAt': Timestamp.now(),
            });
          }

          // Notify listeners that sign in was successful
          notifyListeners();
          return null; // Returning null means success
        } else {
          return 'Failed to get Facebook access token';
        }
      } else {
        return 'Facebook sign in failed: ${result.status}';
      }
    } catch (e) {
      print('Facebook sign in error: $e');
      return e.toString(); // Returning the error message
    }
  }
}
