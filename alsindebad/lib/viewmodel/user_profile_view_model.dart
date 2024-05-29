import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/services/database_service.dart';

class UserProfileViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  User? get currentUser => _auth.currentUser;

  Stream<DocumentSnapshot> getUserDataStream() {
    if (_auth.currentUser == null) {
      throw Exception('No user signed in');
    }
    return _databaseService.getUserProfileStream(_auth.currentUser!.uid);
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

  Future<void> createProfile(UserModel userModel) async {
    try {
      await _databaseService.createUserProfile(userModel);
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

}
