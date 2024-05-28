import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alsindebad/viewmodel/edit_profile_view_model.dart';
import 'package:alsindebad/data/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;

  EditProfileScreen({required this.userModel});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EditProfileViewModel _viewModel = EditProfileViewModel();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCountry;

  List<String> _countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'India',
    'Germany',
    // يمكنك إضافة المزيد من الدول هنا
  ];

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.userModel.name;
    _emailController.text = widget.userModel.email;
    _selectedCountry = _countries.contains(widget.userModel.country) ? widget.userModel.country : _countries.first;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _viewModel.uploadImageToFirebase(widget.userModel.id, _imageFile!);
      }
      final updatedProfile = UserModel(
        id: widget.userModel.id,
        name: _usernameController.text,
        email: _emailController.text,
        country: _selectedCountry!,
        imageUrl: imageUrl ?? widget.userModel.imageUrl,
      );

      await _viewModel.updateUserProfile(userModel: updatedProfile, imageFile: _imageFile);
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
              _buildProfileImage(),
              SizedBox(height: 20),
              _buildInputField('Username', _usernameController),
              SizedBox(height: 20),
              _buildEmailInputField('Email', _emailController),
              SizedBox(height: 20),
              _buildCountryDropdown('Country'),
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

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _imageFile != null
              ? FileImage(_imageFile!)
              : NetworkImage(widget.userModel.imageUrl ?? 'https://via.placeholder.com/150') as ImageProvider,
          backgroundColor: Colors.grey.shade200,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: _pickImage,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$title cannot be empty';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailInputField(String title, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$title cannot be empty';
          } else if (!value.contains('@')) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCountryDropdown(String title) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCountry,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
        ),
        items: _countries.map((String country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(country),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedCountry = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a country';
          }
          return null;
        },
      ),
    );
  }
}
