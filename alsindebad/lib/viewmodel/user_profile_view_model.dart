import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfileViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile?> getUserProfile() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.data() as Map<String, dynamic>, user.uid);
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    await _firestore.collection('users').doc(userProfile.uid).set(userProfile.toMap());
  }
}
