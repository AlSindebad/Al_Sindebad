import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alsindebad/data/models/user.dart';

class ProfileViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUserDataStream() {
    return _firestore.collection('users').doc(_auth.currentUser!.uid).snapshots();
  }

  UserModel getUserProfileFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromSnap(snapshot);
  }
}
