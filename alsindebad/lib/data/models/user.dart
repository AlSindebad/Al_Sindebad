import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String country;
  final String password;
  final String confirmPassword;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.confirmPassword
  });
  factory User.fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return User(
      id: snap["userId"],
      name: snap["name"],
      email: snap["email"],
      password: snap["password"],
      country: snap["country"],
      confirmPassword: snap["confirmPassword"],);
  }
  Map<String,dynamic> toJSON() =>
  {
  "id":id,
    "name":name,
    "email":email,
    "password":password,
    "country":country,
    "confirmPassword":confirmPassword,



  };
}

