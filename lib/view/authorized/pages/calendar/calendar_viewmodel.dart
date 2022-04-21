import 'package:atalay/core/service/service_path.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController dialogTextController;
  late List<CalendarEventData> events = [];
  late EventController eventController = EventController();

  Future<void> getEvents(BuildContext context) async {
    ServicePath.calendarCollectionReference(ServicePath.auth.currentUser!.uid).snapshots().listen((event) {
      events.clear();
      for (var doc in event.docs) {
        final event = CalendarEventData(
          date: DateTime.fromMillisecondsSinceEpoch((doc.get('dateStart') as Timestamp).millisecondsSinceEpoch),
          title: doc.get('title'),
          description: doc.get('description'),
          startTime: DateTime.fromMillisecondsSinceEpoch((doc.get('dateStart') as Timestamp).millisecondsSinceEpoch),
          endTime: DateTime.fromMillisecondsSinceEpoch((doc.get('dateEnd') as Timestamp).millisecondsSinceEpoch),
        );

        events.add(event);
      }
      eventController.addAll(events);
      notifyListeners();
    });
  }
}
