import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/place.dart';


class PlaceInfoViewModel {
  final CollectionReference _placesCollection = FirebaseFirestore.instance.collection('places');

  Future<String?> openGoogleMaps(String? googleMapsUrl) async {
    if (googleMapsUrl != null && await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<Places?> getPlaceInfo(String id) async {
    try {
      DocumentSnapshot snapshot = await _placesCollection.doc(id).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          return Places(
            placeId: snapshot.id,
            placeName: data["name"] ?? "",
            placeReview: data["stars"] ?? 0,
            placeCategory: data["placeCategory"] ?? "",
            placeImage: data["cardImage"] ?? "",
            placeDescription: data["description"] ?? "",
            placelocation: data["placelocation"] ?? "",
            images: List<String>.from(data['images'] ?? []),
            locationUrl: data['locationUrl'] ?? "",
          );
        } else {
          print("Data is null");
          return null;
        }
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
