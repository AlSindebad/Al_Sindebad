import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:alsindebad/viewmodel/user_profile_view_model.dart';
import 'package:alsindebad/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:alsindebad/viewmodel/user_profile_view_model.dart';



import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:alsindebad/services/database_service.dart';

class ProfileViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isUserLoggedIn => _auth.currentUser != null;

  Stream<DocumentSnapshot> getUserDataStream() {
    final String userId = _auth.currentUser?.uid ?? '';
    final DatabaseService db = DatabaseService(uid: userId);
    return db.userData;
  }

  UserProfile getDefaultUserProfile() {
    return UserProfile(
      uid: 'default_uid',
      name: 'Default Username',
      email: 'example@example.com',
      country: 'Default Country',
    );
  }

  UserProfile getUserProfileFromData(Map<String, dynamic> userData) {
    final String userId = _auth.currentUser?.uid ?? '';
    return UserProfile(
      uid: userId,
      name: userData['username'] ?? 'N/A',
      email: userData['email'] ?? 'N/A',
      country: userData['country'] ?? 'N/A',
    );
  }

  Future<UserProfile?> getUserProfile() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.data() as Map<String, dynamic>, user.uid);
  }
}
