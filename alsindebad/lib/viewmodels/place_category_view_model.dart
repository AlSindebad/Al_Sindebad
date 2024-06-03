import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/place.dart';

class PlaceCategory extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Places> _places = [];
  String _selectedCategory = '';

  List<Places> get places => _selectedCategory.isEmpty
      ? _places
      : _places.where((place) => place.placeCategory == _selectedCategory).toList();

  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> data() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('places').get();
      _places = querySnapshot.docs.map((doc) => Places.fromSnapshot(doc)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching places: $e');
    }
  }
}
