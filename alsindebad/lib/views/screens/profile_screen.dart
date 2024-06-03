import 'package:flutter/material.dart';
import 'package:alsindebad/viewmodels/user_profile_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/user.dart';
import 'package:alsindebad/views/screens/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/views/screens/sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_bar_with_just_arrow.dart';
import '../widgets/small_button.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfileViewModel _viewModel = UserProfileViewModel();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final localizations = AppLocalizations.of(context);


    if (user == null) {
      Future.microtask(() => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn(title: 'Sign In'))
      ));
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _viewModel.getUserDataStream(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: CustomAppBarNavigateJustBack(
              title:localizations!.profile,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: CustomAppBarNavigateJustBack(
              title:localizations!.profile,
            ),
            body: Center(
              child: Text('Something went wrong or No data found!'),
            ),
          );
        }

        UserModel userModel = UserModel.fromSnap(snapshot.data!);

        return Scaffold(
          appBar: CustomAppBarNavigateJustBack(
            title:localizations!.profile,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(userModel.imageUrl ?? 'https://via.placeholder.com/150'),
                ),
                SizedBox(height: 10),
                ProfileCard(title: localizations!.name, value: userModel.name),
                SizedBox(height: 10),
                ProfileCard(title: localizations!.email, value: userModel.email),
                SizedBox(height: 10),
                ProfileCard(title:localizations!.country, value: userModel.country),
                SizedBox(height: 10),
            SButton(
              backgroundColor: Color(0xFF112466),
              label: localizations.editProfile,
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
        width: 300 ,
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
