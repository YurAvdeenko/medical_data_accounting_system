import 'package:domain/domain.dart';

class HomeState {
  final User? currentUser;
  final bool isInternetAvailable;
  final String? illness;
  final String? doctor;
  final String? illnessDescription;
  final DateTime? date;
  final List<Event>? event;

  HomeState({
    required this.currentUser,
    required this.isInternetAvailable,
    required this.illness,
    required this.doctor,
    required this.illnessDescription,
    required this.date,
    required this.event,
  });

  factory HomeState.initState() {
    return HomeState(
      currentUser: null,
      isInternetAvailable: true,
      illness: '',
      doctor: '',
      illnessDescription: '',
      date: null,
      event: null,
    );
  }

  HomeState copyWith({
    User? currentUser,
    bool? isInternetAvailable,
    String? illness,
    String? doctor,
    String? illnessDescription,
    DateTime? date,
    List<Event>? event,
  }) {
    return HomeState(
      currentUser: currentUser ?? this.currentUser,
      isInternetAvailable: isInternetAvailable ?? this.isInternetAvailable,
      illness: illness ?? this.illness,
      doctor: doctor ?? this.doctor,
      illnessDescription: illnessDescription ?? this.illnessDescription,
      date: date ?? this.date,
      event: event ?? this.event,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentUser,
        illness,
        doctor,
        illnessDescription,
        date,
        event,
      ];
}
