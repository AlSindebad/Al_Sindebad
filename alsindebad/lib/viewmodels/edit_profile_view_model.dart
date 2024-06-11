import 'dart:io';

import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/services/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileViewModel {
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateUserProfile({
    required UserModel userModel,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToFirebase(userModel.id, imageFile);
      }

      UserModel updatedProfile = UserModel(
          id: userModel.id,
          name: userModel.name,
          email: userModel.email,
          country: userModel.country,
          imageUrl: imageUrl ?? userModel.imageUrl,
          signInMethod:userModel.signInMethod
      );

      await _databaseService.saveUserProfile(updatedProfile);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<String> uploadImageToFirebase(String uid, File image) async {
    try {
      String fileName = 'profile_images/$uid.jpg';
      final UploadTask uploadTask = _storage.ref().child(fileName).putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image to Firebase Storage: $e');
    }
  }
}