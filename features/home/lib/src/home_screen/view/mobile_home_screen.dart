import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';

class MobileHomePage extends StatelessWidget {
  MobileHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.darkBlue,
          body: state.isInternetAvailable
              ? Container(height: 50, width: 50, color: AppColors.red)
              : OfflineNotificationDialog(),
        );
      },
    );
  }
}
