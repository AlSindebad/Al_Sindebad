import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/models/event.dart';
import '../widgets/card_events.dart';
class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<Event>> _events;
  late CalendarFormat _calendarFormat;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    final now = DateTime.now();
    _focusedDay = now;
    _firstDay = now.subtract(const Duration(days: 1000));
    _lastDay = now.add(const Duration(days: 1000));
    _selectedDay = now;
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  Future<void> _loadFirestoreEvents() async {
    final snap = await FirebaseFirestore.instance
        .collection('events')
        .withConverter<Event>(
      fromFirestore: (snapshot, _) => Event.fromFirestore(snapshot),
      toFirestore: (event, _) => event.toFirestore(),
    )
        .get();

    final Map<DateTime, List<Event>> loadedEvents = {};
    for (var doc in snap.docs) {
      final event = doc.data();
      final day = DateTime.utc(event.date.year, event.date.month, event.date.day);
      print('Loaded event: ${event.title} on $day');
      if (loadedEvents[day] == null) {
        loadedEvents[day] = [];
      }
      loadedEvents[day]!.add(event);
    }

    setState(() {
      _events = loadedEvents;
    });
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    print('Requested events for $day');
    final events = _events[day] ?? [];
    print('Events for $day: ${events.map((e) => e.title).toList()}');
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar App')),
      body: Column(
        children: [
          TableCalendar<Event>(
            eventLoader: _getEventsForTheDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            focusedDay: _focusedDay,
            firstDay: _firstDay,
            lastDay: _lastDay,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              weekendTextStyle: TextStyle(color: Colors.red),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF112466),
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  );
                }
                return null;
              },
              headerTitleBuilder: (context, day) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    day.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List<Event> events) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle()
              .copyWith(color: Colors.white, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForTheDay(_selectedDay);
    if (events.isEmpty) {
      return const Center(
        child: Text('No events found!'),
      );
    }
    return ListView(
      children: events
          .map((event) => EventCard(
        eventName: event.title,
        imageUrl: event.imageUrl,
      ))
          .toList(),
    );
  }
}

