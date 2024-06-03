import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../data/models/event.dart';

class EventsViewModel extends ChangeNotifier {
  DateTime _focusedDay;
  final DateTime _firstDay;
  final DateTime _lastDay;
  DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  Map<DateTime, List<Event>> _events;

  EventsViewModel()
      : _focusedDay = DateTime.now(),
        _firstDay = DateTime.now().subtract(const Duration(days: 1000)),
        _lastDay = DateTime.now().add(const Duration(days: 1000)),
        _selectedDay = DateTime.now(),
        _events = LinkedHashMap<DateTime, List<Event>>(
          equals: isSameDay,
          hashCode: (DateTime key) =>
          key.day * 1000000 + key.month * 10000 + key.year,
        ) {
    _loadFirestoreEvents();
  }

  DateTime get focusedDay => _focusedDay;
  DateTime get firstDay => _firstDay;
  DateTime get lastDay => _lastDay;
  DateTime get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  Map<DateTime, List<Event>> get events => _events;

  void updateFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void updateSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void updateCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  Future<void> _loadFirestoreEvents() async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('events')
          .withConverter<Event>(
        fromFirestore: (snapshot, _) => Event.fromFirestore(snapshot),
        toFirestore: (event, _) => event.toFirestore(),
      ).get();

      final Map<DateTime, List<Event>> loadedEvents = {};
      for (var doc in snap.docs) {
        final event = doc.data();
        final day = DateTime.utc(event.date.year, event.date.month, event.date.day);
        loadedEvents.putIfAbsent(day, () => []).add(event);
      }

      _events = loadedEvents;
      notifyListeners();
    } catch (e) {
      // Handle errors appropriately
      debugPrint('Error loading events: $e');
    }
  }

  List<Event> getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  String getLocalizedDayName(BuildContext context, DateTime day) {
    final locale = Localizations.localeOf(context);
    return DateFormat.E(locale.languageCode).format(day);
  }
}
