import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/src/providers/firebase/event_firebase_provider.dart';
import 'package:data/src/providers/firebase/user_firebase_provider.dart';
import 'package:data/src/providers/user_provider.dart';
import 'package:data/src/repositories/user_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:firebase_core/firebase_core.dart';

class DataDi {
  final GetIt _serviceLocator;

  DataDi({
    required GetIt serviceLocator,
  }) : _serviceLocator = serviceLocator;

  Future<void> init() async {
    await _initProviders();
    _initRepositories();
  }

  Future<void> _initProviders() async {
    await Firebase.initializeApp();

    _serviceLocator.registerLazySingleton<UserProvider>(
      () => UserFirebaseProvider(),
    );
    _serviceLocator.registerLazySingleton<AuthProvider>(
      () => AuthProvider(),
    );
    _serviceLocator.registerLazySingleton<EventProvider>(
      () => EventFirebaseProvider(),
    );
  }

  void _initRepositories() {
    _serviceLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userProvider: _serviceLocator.get(),
      ),
    );
    _serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        userProvider: _serviceLocator.get(),
        authProvider: _serviceLocator.get(),
      ),
    );
    _serviceLocator.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(
        eventProvider: _serviceLocator.get(),
        userProvider: _serviceLocator.get(),
      ),
    );
  }
}
