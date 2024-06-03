import 'package:alsindebad/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<String> signup({
    required String name,
    required String email,
    required String country,
    required String password,
    required String confirmPassword,
  }) async {
    String response = "Some Errors";

    if (email.isEmpty || name.isEmpty || password.isEmpty || country.isEmpty || confirmPassword.isEmpty) {
      return "Enter All Fields";
    }

    try {
      final querySnapshot = await users.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return "uniqueEmailError";
      }

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        country: country,
      );
      await users.doc(userCredential.user!.uid).set(user.toJSON());
      response = "Successful";
    } on FirebaseAuthException catch (e) {
      response = e.message ?? "An error occurred";
    }

    return response;
  }
}

