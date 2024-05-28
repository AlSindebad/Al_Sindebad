import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/event.dart';
import 'package:alsindebad/views/widgets/app_bar_with_navigate_back.dart';

class EventScreen extends StatelessWidget {
  final String eventId;

  EventScreen({required this.eventId});

  Future<Event> fetchEvent() async {
    try {
      var doc = await FirebaseFirestore.instance.collection('events').doc(eventId).get();
      if (doc.exists && doc.data() != null) {
        return Event.fromFirestore(doc);
      } else {
        throw Exception("Event not found");
      }
    } catch (e) {
      print("Error fetching event: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20), // زيادة الارتفاع بمقدار 20 بكسل
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0), // إضافة مسافة علوية لإنزال الـ AppBar للأسفل
          child: CustomAppBarNavigateBack(title: 'Event'),
        ),
      ),
      body: FutureBuilder<Event>(
        future: fetchEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            Event event = snapshot.data!;
            print("Event Data: ${event.title}, ${event.imageUrl}"); // Debugging print
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50), // إنزال العناصر للأسفل أكثر
                    Center(
                      child: event.imageUrl.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.only(top: 20.0), // إنزال الصورة للأسفل
                        child: Image.network(
                          event.imageUrl,
                          width: 350, // تحديد العرض المطلوب
                          height: 300, // تحديد الارتفاع المطلوب
                          fit: BoxFit.cover, // لضبط حجم الصورة داخل الأبعاد المحددة
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Error loading image');
                          },
                        ),
                      )
                          : Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity),
                    ),
                    SizedBox(height: 25), // إضافة مسافة بعد الصورة
                    Text(
                      event.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Date: ${event.date.toLocal().toIso8601String().split('T').first}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      event.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
