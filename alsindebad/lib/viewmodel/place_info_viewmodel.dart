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

  Future<Place?> getPlaceInfo(String id) async {
    try {
      DocumentSnapshot<dynamic> snapshot = await _placesCollection.doc(id).get();
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
