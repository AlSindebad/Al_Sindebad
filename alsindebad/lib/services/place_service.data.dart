import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/place.dart';

class PlacesService {
  final CollectionReference placesCollection = FirebaseFirestore.instance.collection('places');

  Future<List<Places>> getPlaces() async {
    try {
      QuerySnapshot querySnapshot = await placesCollection.get();

      List<Places> placesList = querySnapshot.docs.map((doc) {
        return Places.fromSnapshot(doc);
      }).toList();

      return placesList;
    } catch (e) {
      print("Error getting places: $e");
      throw e;
    }
  }
}
