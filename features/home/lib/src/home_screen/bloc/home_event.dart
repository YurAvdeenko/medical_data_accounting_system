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

class RemoveDataEvent implements HomeEvent {
  final int index;

  RemoveDataEvent({required this.index});
}

class GetUser implements HomeEvent {}

class Logout implements HomeEvent {}
