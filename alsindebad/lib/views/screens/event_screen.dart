import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alsindebad/data/models/event.dart';
import 'package:alsindebad/views/widgets/app_bar_with_navigate_back.dart';
import 'package:intl/intl.dart';

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
  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime.toLocal());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Scaffold(
              appBar: CustomAppBarNavigateBack(title: event.title),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    event.imageUrl.isNotEmpty ? Image.network(
                      event.imageUrl,
                      width:MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Error loading image');
                      },
                    )
                        : Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity),
                    SizedBox(height: 25),
                    Center(
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize:28, fontWeight: FontWeight.bold ,color: Color(0xFF112466)),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.description,
                        style: TextStyle(fontSize: 20 ,color: Color(0xFF112466)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Time: ${formatDateTime(event.date)}',
                        style: TextStyle(fontSize: 20 , color: Color(0xFF112466)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Date: ${event.date.toLocal().toIso8601String().split('T').first}',
                        style: TextStyle(fontSize: 20, color: Color(0xFF112466)),
                      ),
                    ),
                    SizedBox(height: 16),
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
