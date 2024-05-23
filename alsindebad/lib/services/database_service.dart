import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots();
  }
}
