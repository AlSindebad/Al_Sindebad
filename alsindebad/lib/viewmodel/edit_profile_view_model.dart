import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:alsindebad/viewmodel/user_profile_view_model.dart';

class EditProfileViewModel {
  final UserProfileViewModel _userProfileViewModel = UserProfileViewModel();

  File? _image;
  File? get image => _image;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  Future<void> saveProfile(UserProfile userProfile) async {
    await _userProfileViewModel.updateUserProfile(userProfile);
  }
}
