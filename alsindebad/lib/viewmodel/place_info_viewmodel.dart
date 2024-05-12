import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/place.dart';

class PlaceInfoViewModel {
  final CollectionReference _placesCollection = FirebaseFirestore.instance.collection('places');

  Future<Place?> getPlaceInfo(String id) async {
    try {
      DocumentSnapshot<dynamic> snapshot = await _placesCollection.doc(id).get();
      print('Fetching Firestore document with ID: $id');
      if (snapshot.exists) {
        print('Document data: ${snapshot.data()}');
        return Place.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        print('No document found with ID: $id');
        return null;
      }

    } catch (e) {
      print('Failed to get place info: $e');
      return null;
    }
  }
}
