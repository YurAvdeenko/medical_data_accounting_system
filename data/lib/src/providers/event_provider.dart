import 'package:data/src/model/event.dart';

abstract class EventProvider {
  Future<void> insert(String id, String doctor, String illness, String illnessDescription, DateTime date);

  Stream<List<Event>> getCurrentEvents(String userId);
}
