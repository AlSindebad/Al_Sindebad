import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/viewmodel/edit_profile_view_model.dart';
class EditProfileScreen extends StatelessWidget {
  final UserModel userModel;
  EditProfileScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel()..initialize(userModel),
      child: Consumer<EditProfileViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileImage(viewModel),
                    SizedBox(height: 20),
                    _buildInputField('Username', viewModel.usernameController, context),
                    SizedBox(height: 20),
                    _buildEmailInputField('Email', viewModel.emailController, context),
                    SizedBox(height: 20),
                    _buildCountryDropdown(viewModel, context),
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
                          onPressed: () async {
                            await viewModel.saveProfile(userModel, context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildProfileImage(EditProfileViewModel viewModel) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: viewModel.imageFile != null
              ? FileImage(viewModel.imageFile!)
              : NetworkImage(userModel.imageUrl ?? 'https://via.placeholder.com/150') as ImageProvider,
          backgroundColor: Colors.grey.shade200,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: viewModel.pickImage,
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
  Widget _buildInputField(String title, TextEditingController controller, BuildContext context) {
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
  Widget _buildEmailInputField(String title, TextEditingController controller, BuildContext context) {
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
  Widget _buildCountryDropdown(EditProfileViewModel viewModel, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: viewModel.selectedCountry,
        decoration: InputDecoration(
          labelText: 'Country',
          border: OutlineInputBorder(),
        ),
        items: viewModel.countries.map((String country) {
          return DropdownMenuItem<String>(
            value: country,
            child: Text(country),
          );
        }).toList(),
        onChanged: (String? newValue) {
          viewModel.selectedCountry = newValue;
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