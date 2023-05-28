abstract class AuthEvent {
  AuthEvent();
}

class SignInWithEmailAndPasswordEvent implements AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class SignInWithAppleEvent implements AuthEvent {
  SignInWithAppleEvent();
}

class SignInWithGoogleEvent implements AuthEvent {
  SignInWithGoogleEvent();
}

class UpdateUserRegisteredStatusEvent implements AuthEvent {
  UpdateUserRegisteredStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserNotRegisteredStatusEvent implements AuthEvent {
  UpdateUserNotRegisteredStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckOfflineModeEvent implements AuthEvent {
  final bool isInternetAvailable;

  CheckOfflineModeEvent({
    required this.isInternetAvailable,
  });
}

class RegisterWithEmailAndPasswordEvent implements AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
