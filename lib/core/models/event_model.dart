import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String event;
  Timestamp createdAt;
  Timestamp eventTime;

  EventModel({
    required this.event,
    required this.createdAt,
    required this.eventTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'createdAt': createdAt,
      'eventTime': eventTime,
    };
  }
}
