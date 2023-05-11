import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';
import 'package:home/src/home_screen/bloc/home_event.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';
import 'package:home/src/home_screen/widgets/home_add_dialog.dart';
import 'package:home/src/home_screen/widgets/home_appbar.dart';
import 'package:home/src/home_screen/widgets/home_floating_action_button.dart';
import 'package:home/src/home_screen/widgets/home_item.dart';

class MobileHomePage extends StatelessWidget {
  MobileHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        authRepository: appDependencies.get<AuthRepository>(),
        userRepository: appDependencies.get<UserRepository>(),
      ),
      child: _MobileHomePage(),
    );
  }
}

class _MobileHomePage extends StatelessWidget {
  _MobileHomePage();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.backgroundHome,
          appBar: HomeAppBar(
            //todo add loc
            title: 'Medical data accounting system',
            onSignOut: () {
              bloc.add(Logout());
            },
          ),
          floatingActionButton: HomeFloatingActionButton(
            //todo add logic
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HomeDialogWidget();
                  });
            },
          ),
          body: state.isInternetAvailable
              ? state.event != null
                  ? Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        ListView.separated(
                          itemCount: state.event!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: HomeItemWidget(
                                doctor: state.event![index].illness,
                                date: state.event![index].date.toString(),
                                illness: state.event![index].illness,
                                illnessDescription: state.event![index].illnessDescription,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10);
                          },
                        )
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Add Event. Press the button bellow',
                        style: AppTextStyle.rubicRegularLoginButton20,
                      ),
                    )
              : OfflineNotificationDialog(),
        );
      },
    );
  }
}
