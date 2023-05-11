import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';

class HomeItemDialogWidget extends StatelessWidget {
  final String doctor;
  final String illness;
  final String illnessDescription;
  final String date;

  HomeItemDialogWidget({
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });

  //todo investigate why we can handle this provider

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        authRepository: appDependencies.get<AuthRepository>(),
        userRepository: appDependencies.get<UserRepository>(),
      ),
      child: _HomeDialogWidgetState(
        doctor: doctor,
        illness: illness,
        illnessDescription: illnessDescription,
        date: date,
      ),
    );
  }
}

class _HomeDialogWidgetState extends StatelessWidget {
  final String doctor;
  final String illness;
  final String illnessDescription;
  final String date;

  _HomeDialogWidgetState({
    required this.doctor,
    required this.illness,
    required this.illnessDescription,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.violetSocial,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    //todo add loc
                    'Your Event - $date',
                    style: AppTextStyle.rubicRegular20,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        Text(illness),
                        const SizedBox(height: 10.0),
                        Text(doctor),
                        const SizedBox(height: 10.0),
                        Text(illnessDescription),
                        const SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            //todo add loc
                            child: const Text('Back'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
