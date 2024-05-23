import 'package:flutter/material.dart';
import 'dart:io';
import 'package:alsindebad/viewmodel/edit_profile_view_model.dart';
import 'package:alsindebad/data/models/user_profile.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:alsindebad/viewmodel/edit_profile_view_model.dart';
import 'package:alsindebad/data/models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  EditProfileScreen({required this.userProfile});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EditProfileViewModel _viewModel = EditProfileViewModel();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.userProfile.name;
    _emailController.text = widget.userProfile.email;
    _countryController.text = widget.userProfile.country;
  }

  Future<void> _pickImage() async {
    await _viewModel.pickImage();
    setState(() {});
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = UserProfile(
        uid: widget.userProfile.uid,
        name: _usernameController.text,
        email: _emailController.text,
        country: _countryController.text,
      );

      await _viewModel.saveProfile(updatedProfile);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _viewModel.image != null ? FileImage(_viewModel.image!) : null,
                    child: _viewModel.image == null
                        ? Icon(Icons.person, size: 80, color: Color(0xFF112466))
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, size: 30, color: Color(0xFF112466)),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildInputField('Username', _usernameController),
              SizedBox(height: 20),
              _buildInputField('Email', _emailController),
              SizedBox(height: 20),
              _buildInputField('Country', _countryController),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF112466)),
                    child: Text('Save'),
                    onPressed: _saveProfile,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String title, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
