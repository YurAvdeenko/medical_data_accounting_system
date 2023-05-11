import 'package:core/src/di/service_locator.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';
import 'package:auth/src/auth_screen/bloc/auth_bloc.dart';
import 'package:home/src/home_screen/bloc/home_event.dart';

//todo implement or remove
class ProvidersBloc extends StatelessWidget {
  final Widget child;

  const ProvidersBloc({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: serviceLocator.get<AuthRepository>(),
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            authRepository: serviceLocator.get<AuthRepository>(),
            userRepository: serviceLocator.get<UserRepository>(),
          )..add(GetUser()),
        ),
      ],
      child: child,
    );
  }
}
