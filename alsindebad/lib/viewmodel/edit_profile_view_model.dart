import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:alsindebad/data/models/user.dart';

import 'package:image_picker/image_picker.dart';


import 'package:alsindebad/services/database_service.dart';

class EditProfileViewModel with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  final DatabaseService _databaseService = DatabaseService();
  File? imageFile;
  String? selectedCountry;
  List<String> countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Germany',
  ];

  void initialize(UserModel userModel) {
    usernameController.text = userModel.name;
    emailController.text = userModel.email;
    selectedCountry = countries.contains(userModel.country) ? userModel.country : countries.first;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> saveProfile(UserModel userModel) async {
    if (formKey.currentState!.validate()) {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToFirebase(userModel.id, imageFile!);
      }
      final updatedProfile = UserModel(
        id: userModel.id,
        name: usernameController.text,
        email: emailController.text,
        country: selectedCountry!,
        imageUrl: imageUrl ?? userModel.imageUrl,
      );

      await _databaseService.saveUserProfile(updatedProfile);
      notifyListeners();
    }
  }

  Future<String> uploadImageToFirebase(String uid, File image) async {
    try {
      String fileName = 'profile_images/$uid.jpg';

      final UploadTask uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(image);
      final Reference ref = _storage.ref().child(fileName);
      final UploadTask uploadTask = ref.putFile(image);

      final TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image to Firebase Storage: $e');
    }
  }
}
