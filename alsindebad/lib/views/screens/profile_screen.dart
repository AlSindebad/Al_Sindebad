import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alsindebad/viewmodel/user_profile_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/views/screens/edit_profile_screen.dart';
import 'package:alsindebad/views/screens/signin.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProfileViewModel(),
      child: Consumer<UserProfileViewModel>(
        builder: (context, viewModel, child) {
          final User? user = viewModel.currentUser;

          if (user == null) {
            Future.microtask(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignIn(title: 'Sign In')),
            ));
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return StreamBuilder<DocumentSnapshot>(
            stream: viewModel.getUserDataStream(),
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

              UserModel userModel = viewModel.getUserProfileFromSnapshot(snapshot.data!);

              return Scaffold(
                appBar: AppBar(
                  title: Text('Profile'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(userModel.imageUrl ?? 'https://via.placeholder.com/150'),
                        ),
                        SizedBox(height: 20),
                        ProfileCard(title: 'Username', value: userModel.name),
                        SizedBox(height: 20),
                        ProfileCard(title: 'Email', value: userModel.email),
                        SizedBox(height: 20),
                        ProfileCard(title: 'Country', value: userModel.country),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF112466)),
                          child: Text('Edit Profile'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfileScreen(userModel: userModel)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
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
            side: BorderSide(color: Color(0xFF112466)),
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
