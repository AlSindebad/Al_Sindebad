import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/event.dart';
import '../../viewmodels/event_view_model.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import '../widgets/card_events.dart';
import 'event_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (_) => EventsViewModel(),
      child: Scaffold(
        appBar: CustomAppBarNavigateBack(title: localizations!.events),
        body: Column(
          children: [
            Consumer<EventsViewModel>(
              builder: (context, viewModel, child) {
                return TableCalendar<Event>(
                  eventLoader: viewModel.getEventsForTheDay,
                  focusedDay: viewModel.focusedDay,
                  firstDay: viewModel.firstDay,
                  lastDay: viewModel.lastDay,
                  selectedDayPredicate: (day) => isSameDay(day, viewModel.selectedDay),
                  onDaySelected: (selectedDay, focusedDay) {
                    viewModel.updateSelectedDay(selectedDay);
                    viewModel.updateFocusedDay(focusedDay);
                  },
                  onPageChanged: (focusedDay) => viewModel.updateFocusedDay(focusedDay),
                  calendarFormat: viewModel.calendarFormat,
                  onFormatChanged: (format) {
                    viewModel.updateCalendarFormat(format);
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
                      final dayName = viewModel.getLocalizedDayName(context, day);
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          dayName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    dowBuilder: (context, day) {
                      final locale = Localizations.localeOf(context);
                      final dayName = DateFormat.E(locale.languageCode).format(day);
                      return Center(
                        child: Text(
                          dayName,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Consumer<EventsViewModel>(
                builder: (context, viewModel, child) {
                  final events = viewModel.getEventsForTheDay(viewModel.selectedDay);
                  if (events.isEmpty) {
                    return Center(
                      child: Text(localizations.noEvents ?? 'No events'),
                    );
                  }
                  return ListView(
                    children: events.map((event) {
                      return GestureDetector(
                        key: ValueKey(event.id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventScreen(eventId: event.id),
                            ),
                          );
                        },
                        child: EventCard(
                          eventName: event.title,
                          imageUrl: event.imageUrl,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
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
          style: const TextStyle().copyWith(color: Colors.white, fontSize: 12.0),
        ),
      ),
    );
  }
}
