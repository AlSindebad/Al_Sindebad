import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String? description;
  final DateTime date;
  final String id;
  final String imageUrl;  // Add this line

  Event({
    required this.title,
    this.description,
    required this.date,
    required this.id,
    required this.imageUrl,  // Add this line
  });

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      date: data['date'].toDate(),
      title: data['title'],
      description: data['description'],
      id: snapshot.id,
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "title": title,
      "description": description,
      "imageUrl": imageUrl
    };
  }
}