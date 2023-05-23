import 'package:domain/domain.dart';

abstract class EventRepository {
  Stream<Future<List<Event>>> getCurrentEvents();

  Future<Event?> uploadNewEvent(EventParams params);
}

class EventParams {
  final String id;
  final String doctor;
  final String illness;
  final String illnessDescription;
  final DateTime? date;

  EventParams({
    required this.id,
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });
}
