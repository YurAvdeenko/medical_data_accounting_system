import 'package:equatable/equatable.dart';

class AuthState extends Equatable{
  final bool isUserRegistered;
  final bool isInternetAvailable;

  AuthState({
    required this.isUserRegistered,
    required this.isInternetAvailable,
  });

  factory AuthState.initState() {
    return AuthState(
      isUserRegistered: true,
      isInternetAvailable: true,
    );
  }

  AuthState copyWith({
    bool? isUserRegistered,
    bool? isInternetAvailable,
  }) {
    return AuthState(
      isUserRegistered: isUserRegistered ?? this.isUserRegistered,
      isInternetAvailable: isInternetAvailable ?? this.isInternetAvailable,
    );
  }

  @override
  List<Object> get props => <Object>[isUserRegistered, isInternetAvailable];
}
