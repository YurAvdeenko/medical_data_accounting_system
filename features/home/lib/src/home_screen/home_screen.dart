import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';
import 'package:home/src/home_screen/view/mobile_home_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        userRepository: appDependencies.get<UserRepository>(),
        authRepository: appDependencies.get<AuthRepository>(),
      ),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final User? currentUser = state.currentUser;
          if (currentUser == null) {
            return const AppProgressIndicator();
          } else {
            return MobileHomePage();
          }
        },
      ),
    );
  }
}
