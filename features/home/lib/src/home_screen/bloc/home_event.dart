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

class EnterDoctorEvent implements HomeEvent {
  final String? value;

  EnterDoctorEvent({required this.value});
}

class EnterIllnessEvent implements HomeEvent {
  final String? value;

  EnterIllnessEvent({required this.value});
}

class EnterIllnessDescriptionEvent implements HomeEvent {
  final String? value;

  EnterIllnessDescriptionEvent({required this.value});
}

class EnterDateEvent implements HomeEvent {
  final DateTime? value;

  EnterDateEvent({required this.value});
}

class SubmitDataEvent implements HomeEvent {
  final Event? value;

  SubmitDataEvent({required this.value});
}

class GetUser implements HomeEvent {}

class Logout implements HomeEvent {}
