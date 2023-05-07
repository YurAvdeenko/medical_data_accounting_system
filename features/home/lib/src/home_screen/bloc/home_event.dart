abstract class HomeEvent {
  HomeEvent();
}

class CheckOfflineMode implements HomeEvent {
  final bool isInternetAvailable;

  CheckOfflineMode({
    required this.isInternetAvailable,
  });
}

class GetUser implements HomeEvent {}

class Logout implements HomeEvent {}
