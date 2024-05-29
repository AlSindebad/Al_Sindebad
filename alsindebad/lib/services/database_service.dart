import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel> getUserProfile(String uid) async {
    DocumentSnapshot snapshot = await _db.collection('users').doc(uid).get();
    return UserModel.fromSnap(snapshot);
  }

  Stream<DocumentSnapshot> getUserProfileStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  Future<void> saveUserProfile(UserModel userModel) async {
    try {
      await _db.collection('users').doc(userModel.id).set(userModel.toJSON());
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  Future<void> createUserProfile(UserModel userModel) async {
    try {
      await _db.collection('users').doc(userModel.id).set(userModel.toJSON());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }
}
