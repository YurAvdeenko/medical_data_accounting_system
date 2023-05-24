import 'package:domain/domain.dart';

abstract class HomeEvent {
  HomeEvent();
}

class CheckOfflineMode implements HomeEvent {
  final bool isInternetAvailable;

  CheckOfflineMode({
    required this.isInternetAvailable,
  });
}

class SubmitDataEvent implements HomeEvent {
  final Event value;

  SubmitDataEvent({required this.value});
}

class RemoveEvent implements HomeEvent {
  final String eventId;

  RemoveEvent({required this.eventId});
}

class EventsUpdated implements HomeEvent {
  final List<Event> allEvents;

  EventsUpdated({required this.allEvents});
}

class Logout implements HomeEvent {}

class UploadEvent implements HomeEvent {
  final String doctor;
  final String illness;
  final String illnessDescription;
  final DateTime date;

  UploadEvent({
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });
}

class Init implements HomeEvent {
  const Init();
}
