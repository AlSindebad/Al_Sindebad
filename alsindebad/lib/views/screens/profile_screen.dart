import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/views/screens/edit_profile_screen.dart';
import 'package:alsindebad/views/widgets/mediumButton.dart';
import 'package:alsindebad/data/models/user_profile.dart';
import 'package:alsindebad/services/database_service.dart';// تأكد من تحديث المسار الصحيح

import 'package:alsindebad/viewmodel/profile_view_model.dart';





class ProfileScreen extends StatelessWidget {
  final ProfileViewModel _viewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _viewModel.getUserDataStream(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Center(
              child: Text('Something went wrong or No data found!'),
            ),
          );
        }

        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        UserProfile userProfile = _viewModel.getUserProfileFromData(data);

        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                ProfileCard(title: 'Username', value: userProfile.name),
                SizedBox(height: 20),
                ProfileCard(title: 'Email', value: userProfile.email),
                SizedBox(height: 20),
                ProfileCard(title: 'Country', value: userProfile.country),
                SizedBox(height: 20),
                CustomOutlinedButton(
                  text: 'Edit Profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfileScreen(userProfile: userProfile)),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final String value;

  ProfileCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.grey[400]!),
          ),
          color: Colors.white,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(value),
          ),
        ),
      ),
    );
  }
}
