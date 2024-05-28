import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String country;
  final String password;
  final String confirmPassword;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.confirmPassword,
    this.imageUrl,
  });

  factory UserModel.fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snapshot.id,
      name: snap["name"],
      email: snap["email"],
      password: snap["password"],
      country: snap["country"],
      confirmPassword: snap["confirmPassword"],
      imageUrl: snap["imageUrl"],
    );
  }

  Map<String, dynamic> toJSON() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "country": country,
    "confirmPassword": confirmPassword,
    "imageUrl": imageUrl,
  };
}
