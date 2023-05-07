import 'package:auth/src/auth_screen/bloc/auth_bloc.dart';
import 'package:auth/src/auth_screen/bloc/auth_state.dart';
import 'package:auth/src/auth_screen/view/mobile_auth_screen.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: serviceLocator.get<AuthRepository>(),
      ),
      child: const _AuthorizationPage(),
    );
  }
}

class _AuthorizationPage extends StatelessWidget {
  const _AuthorizationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MobileAuthorizationPage();
        },
      ),
    );
  }
}
