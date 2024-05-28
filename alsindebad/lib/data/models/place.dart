
  import 'package:cloud_firestore/cloud_firestore.dart';

  class Places {
    String placeId;
    String placeName;
    double averageRating;
    String placeCategory;
    String placeImage;
    final List<String> images;
    String placeDescription;
    String placelocation;
    final String locationUrl;
    final Map<String, int> reviews;

  Places({
    required this.placeId,
    required this.placeName,
    required this.averageRating,
    required this.placeCategory,
    required this.placeImage,
    required this.placeDescription,
    required this.placelocation,
    required this.images,
    required this.locationUrl,
    required this.reviews,
  });

  factory Places.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Places(
      placeId: snap.id,
      placeName: snapshot["name"] ?? "",
      averageRating: (snapshot["averageRating"] ?? 0).toDouble(),
      placeCategory: snapshot["placeCategory"] ?? "",
      placeImage: snapshot["cardImage"] ?? "",
      placeDescription: snapshot["description"] ?? "",
      placelocation: snapshot["placelocation"] ?? "",
      images: List<String>.from(snapshot['images'] ?? []),
      locationUrl: snapshot['locationUrl'] ?? '',
      reviews: Map<String, int>.from(snapshot['reviews'] ?? {}),
    );
  }
}
