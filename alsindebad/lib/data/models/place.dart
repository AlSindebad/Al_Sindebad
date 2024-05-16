import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Places {
  String placeId;
  String placeName;
  int placeReview;
  String placeCategory;
  String placeImage;
  final List<String> images;
  String placeDescription;
  String placelocation;
  final String locationUrl;


  Places({
    required this.placeId,
    required this.placeName,
    required this.placeReview,
    required this.placeCategory,
    required this.placeImage,
    required this.placeDescription,
    required this.placelocation,
    required this.images,
    required this.locationUrl,


  });
  factory Places.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Places(
      placeId: snap.id,
      placeName: snapshot["name"] ?? "",
      placeReview: snapshot["stars"] ?? 0,
      placeCategory: snapshot["placeCategory"] ?? "",
      placeImage: snapshot["cardImage"] ?? "",
      placeDescription: snapshot["description"] ?? "",
      placelocation: snapshot["placelocation"] ?? "",
      images: List<String>.from(snapshot['images'] ?? []),
      locationUrl: snapshot['locationUrl'] ?? '',

    );
  }


}







