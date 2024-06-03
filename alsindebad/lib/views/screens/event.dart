import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/models/event.dart';
import '../../viewmodels/event_view_model.dart';
import '../widgets/app_bar_with_navigate_back.dart';
import '../widgets/card_events.dart';
import 'event_screen.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsViewModel(),
      child: Scaffold(
        appBar: CustomAppBarNavigateBack(title: 'Events'),
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
                  calendarFormat: CalendarFormat.month,
                  onFormatChanged: (format) {},
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
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    return const Center(
                      child: Text('No events found!'),
                    );
                  }
                  return ListView(
                    children: events.map((event) {
                      return GestureDetector(
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
