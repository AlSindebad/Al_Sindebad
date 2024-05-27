import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String imageUrl;
  final DateTime date;

  Event({
    required this.title,
    required this.imageUrl,
    required this.date,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Event(
      title: data['title'],
      imageUrl: data['imageUrl'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'date': date,
    };
  }
}
