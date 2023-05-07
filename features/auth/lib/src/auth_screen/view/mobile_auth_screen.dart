import 'package:auth/src/auth_screen/bloc/auth_bloc.dart';
import 'package:auth/src/auth_screen/bloc/auth_event.dart';
import 'package:auth/src/auth_screen/bloc/auth_state.dart';
import 'package:auth/src/auth_screen/widgets/auth_form/login_form.dart';
import 'package:auth/src/auth_screen/widgets/auth_form/registration_form.dart';
import 'package:auth/src/auth_screen/widgets/logo_with_label.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class MobileAuthorizationPage extends StatelessWidget {
  MobileAuthorizationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: serviceLocator.get<AuthRepository>(),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.darkBlue,
            body: state.isInternetAvailable!
                ? Column(
                    children: <Widget>[
                      const Spacer(flex: 2),
                      LogoWithLabel(mainAxisAlignment: MainAxisAlignment.center),
                      state.isUserRegistered!
                          ? Expanded(
                              flex: 7,
                              child: Column(
                                children: <Widget>[
                                  LoginForm(
                                    label: 'general.login_uppercase'.tr(),
                                    context: context,
                                    onTap: (String email, String password) {
                                      bloc.add(
                                        SignInWithEmailAndPasswordEvent(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'general.not_registered'.tr(),
                                      style: AppTextStyle.rubicItalic20,
                                    ),
                                    onTap: () {
                                      bloc.add(
                                        UpdateUserRegistrationStatusEvent(
                                          isUserRegister: false,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppDimensions.padding10),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding20),
                                    child: Divider(color: AppColors.textHintColor),
                                  ),
                                  const SizedBox(height: AppDimensions.padding10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => context.read<AuthBloc>().add(
                                                SignInWithGoogleEvent(),
                                              ),
                                          icon: Image.asset(
                                            'assets/images/google_icon.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppDimensions.padding10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => bloc.add(SignInWithAppleEvent()),
                                          icon: Image.asset(
                                            'assets/images/apple_logo.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppDimensions.padding10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => bloc.add(SignInWithFacebookEvent()),
                                          icon: Image.asset(
                                            'assets/images/facebook_logo.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              flex: 12,
                              child: Column(
                                children: <Widget>[
                                  RegistrationForm(
                                    label: 'general.register_uppercase'.tr(),
                                    context: context,
                                    onTap: (String email, String password, String firstName, String lastName) {
                                      bloc.add(
                                        RegisterWithEmailAndPasswordEvent(
                                          email: email,
                                          password: password,
                                          firstName: firstName,
                                          lastName: lastName,
                                        ),
                                      );
                                    },
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'general.already_registered'.tr(),
                                      style: AppTextStyle.rubicItalic20,
                                    ),
                                    onTap: () {
                                      bloc.add(
                                        UpdateUserRegistrationStatusEvent(isUserRegister: true),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: AppDimensions.padding10),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding20),
                                    child: Divider(color: AppColors.textHintColor),
                                  ),
                                  const SizedBox(height: AppDimensions.padding10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => bloc.add(SignInWithGoogleEvent()),
                                          icon: Image.asset(
                                            'assets/images/google_icon.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppDimensions.padding10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => bloc.add(SignInWithAppleEvent()),
                                          icon: Image.asset(
                                            'assets/images/apple_logo.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppDimensions.padding10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius16),
                                          color: AppColors.white,
                                        ),
                                        child: IconButton(
                                          onPressed: () => bloc.add(SignInWithFacebookEvent()),
                                          icon: Image.asset(
                                            'assets/images/facebook_logo.png',
                                            height: AppDimensions.imageSize40,
                                            width: AppDimensions.imageSize40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      const Spacer(flex: 2),
                    ],
                  )
                : OfflineNotificationDialog(),
          );
        },
      ),
    );
  }
}