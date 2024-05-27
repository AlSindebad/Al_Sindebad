import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/event.dart';

class EventsViewModel extends ChangeNotifier {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<Event>> _events;

  EventsViewModel() {
    final now = DateTime.now();
    _focusedDay = now;
    _firstDay = now.subtract(const Duration(days: 1000));
    _lastDay = now.add(const Duration(days: 1000));
    _selectedDay = now;
    _events = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _loadFirestoreEvents();
  }

  DateTime get focusedDay => _focusedDay;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  DateTime get selectedDay => _selectedDay;
  Map<DateTime, List<Event>> get events => _events;

  void updateFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void updateSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
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
      if (loadedEvents[day] == null) {
        loadedEvents[day] = [];
      }
      loadedEvents[day]!.add(event);
    }

    _events = loadedEvents;
    notifyListeners();
  }

  List<Event> getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }
}
