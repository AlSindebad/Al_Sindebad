import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String country;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    this.imageUrl,
  });

  factory UserModel.fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      id: snap["id"],
      name: snap["name"],
      email: snap["email"],
      country: snap["country"],
      imageUrl: snap["imageUrl"],
    );
  }

  Map<String, dynamic> toJSON() => {
    "id": id,
    "name": name,
    "email": email,
    "country": country,
    "imageUrl": imageUrl,
  };
}


