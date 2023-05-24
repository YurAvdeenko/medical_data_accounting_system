import 'package:domain/domain.dart';

abstract class EventRepository {
  Stream<Future<List<Event>>> observeAll();

  Future<void> deleteById(String eventId);

  Future<void> uploadNewEvent(EventParams params);
}

class EventParams {
  final String userId;
  final String doctor;
  final String illness;
  final String illnessDescription;
  final DateTime? date;

  EventParams({
    required this.userId,
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });
}
