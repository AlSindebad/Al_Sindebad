import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/services/database_service.dart';

class UserProfileViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseService _databaseService = DatabaseService();

  Stream<DocumentSnapshot> getUserDataStream() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots();
  }

  UserModel getUserProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromSnap(snapshot);
  }

  Future<UserModel> getUserProfile(String uid) async {
    try {
      return await _databaseService.getUserProfile(uid);
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  Future<void> saveProfile(UserModel userModel) async {
    try {
      await _databaseService.saveUserProfile(userModel);
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }
}
