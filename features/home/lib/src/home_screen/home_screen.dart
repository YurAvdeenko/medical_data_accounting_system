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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        userRepository: appDependencies.get<UserRepository>(),
        authRepository: appDependencies.get<AuthRepository>(),
        eventRepository: appDependencies.get<EventRepository>(),
      ),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundHome,
      appBar: HomeAppBar(
        title: 'general.medical_data_accounting_system'.tr(),
        onSignOut: () {
          bloc.add(Logout());
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final User? currentUser = state.currentUser;
          if (currentUser == null || state.isLoading) {
            return const AppProgressIndicator();
          }
          if (!state.isInternetAvailable) {
            return OfflineNotificationDialog();
          }
          return Stack(
            children: <Widget>[
              state.events.isNotEmpty
                  ? Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        ListView.separated(
                          itemCount: state.events.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final Event event = state.events[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: HomeItemWidget(
                                event: event,
                                delete: () => bloc.add(RemoveEvent(eventId: event.id)),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10);
                          },
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        'general.press_the_button_bellow_message'.tr(),
                        style: AppTextStyle.rubicRegular20.copyWith(color: AppColors.darkBlue),
                      ),
                    ),
              Positioned(
                bottom: 30,
                right: 20,
                child: HomeFloatingActionButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return HomeAddDialogWidget(
                          submit: (
                            String doctor,
                            String illness,
                            String illnessDescription,
                            DateTime date,
                          ) =>
                              bloc.add(
                            UploadEvent(
                              doctor: doctor,
                              illness: illness,
                              illnessDescription: illnessDescription,
                              date: date,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
