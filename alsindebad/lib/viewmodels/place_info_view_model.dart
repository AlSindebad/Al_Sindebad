import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/place.dart';

class PlaceInfoViewModel {
  final CollectionReference _placesCollection = FirebaseFirestore.instance.collection('places');
  late final String userId;

  PlaceInfoViewModel() {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> openGoogleMaps(String googleMapsUrl) async {
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<Places?> getPlaceInfo(String id) async {
    try {
      DocumentSnapshot snapshot = await _placesCollection.doc(id).get();
      if (snapshot.exists) {
        return Places.fromSnapshot(snapshot);
      } else {
        print('No document found with ID: $id');
        return null;
      }
    } catch (e) {
      print('Failed to get place info: $e');
      return null;
    }
  }

  Future<int?> getUserReview(String placeId) async {
    try {
      DocumentSnapshot snapshot = await _placesCollection.doc(placeId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data['reviews'] != null && data['reviews'][userId] != null) {
          return data['reviews'][userId];
        }
      }
      return null;
    } catch (e) {
      print('Failed to get user review: $e');
      return null;
    }
  }

  Future<void> submitReview(String placeId, int rating) async {
    try {

      DocumentReference placeRef = _placesCollection.doc(placeId);
      DocumentSnapshot placeSnapshot = await placeRef.get();
      if (placeSnapshot.exists) {
        Map<String, dynamic>? placeData = placeSnapshot.data() as Map<String, dynamic>?;

        double currentAverageRating = placeData?['averageRating'] ?? 0.0;
        Map<String, dynamic> reviews = Map<String, dynamic>.from(placeData?['reviews'] ?? {});

        if (reviews.containsKey(userId)) {
          int oldRating = reviews[userId];
          double oldAverageRating = currentAverageRating * reviews.length - oldRating;
          reviews[userId] = rating;
          double newAverageRating = (oldAverageRating + rating) / reviews.length;
          await placeRef.update({
            'averageRating': newAverageRating,
            'reviews': reviews,
          });
        } else {

          reviews[userId] = rating;
          double newAverageRating = (currentAverageRating * reviews.length + rating) / (reviews.length + 1);
          await placeRef.update({
            'averageRating': newAverageRating,
            'reviews': reviews,
          });
        }
      }
    } catch (e) {
      print('Error submitting review: $e');
    }
  }

}
