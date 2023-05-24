import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final User? currentUser;
  final bool isInternetAvailable;
  final String? illness;
  final String? doctor;
  final String? illnessDescription;
  final DateTime? date;
  final List<Event> events;
  final bool isLoading;

  HomeState({
    required this.currentUser,
    required this.isInternetAvailable,
    required this.illness,
    required this.doctor,
    required this.illnessDescription,
    required this.date,
    required this.events,
    required this.isLoading,
  });

  factory HomeState.initState() {
    return HomeState(
      currentUser: null,
      isInternetAvailable: true,
      illness: '',
      doctor: '',
      illnessDescription: '',
      date: null,
      events: [],
      isLoading: true,
    );
  }

  HomeState copyWith({
    User? currentUser,
    bool? isInternetAvailable,
    String? illness,
    String? doctor,
    String? illnessDescription,
    DateTime? date,
    List<Event>? events,
    bool? isLoading,
  }) {
    return HomeState(
      currentUser: currentUser ?? this.currentUser,
      isInternetAvailable: isInternetAvailable ?? this.isInternetAvailable,
      illness: illness ?? this.illness,
      doctor: doctor ?? this.doctor,
      illnessDescription: illnessDescription ?? this.illnessDescription,
      date: date ?? this.date,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentUser,
        illness,
        doctor,
        illnessDescription,
        date,
        events,
        isLoading,
      ];
}
