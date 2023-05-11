class Event {
  final String id;
  final String doctor;
  final String illness;
  final String illnessDescription;
  final DateTime? date;

  //todo rename
  Event({
    required this.id,
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });
}
