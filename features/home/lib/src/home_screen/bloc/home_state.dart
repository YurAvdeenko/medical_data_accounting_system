import 'package:domain/domain.dart';

class HomeState {
  final User? currentUser;
  final bool isInternetAvailable;

  HomeState({
    required this.currentUser,
    required this.isInternetAvailable,
  });

  factory HomeState.initState() {
    return HomeState(
      currentUser: null,
      isInternetAvailable: true,
    );
  }

  HomeState copyWith({
    User? currentUser,
    bool? isInternetAvailable,
  }) {
    return HomeState(
      currentUser: currentUser ?? this.currentUser,
      isInternetAvailable: isInternetAvailable ?? this.isInternetAvailable,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentUser,
        isInternetAvailable,
      ];
}
