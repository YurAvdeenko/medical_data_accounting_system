class Event {
  final String id;
  final String userId;
  final String doctor;
  final String illness;
  final String illnessDescription;
  final String date;

  Event({
    required this.id,
    required this.userId,
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });
}
