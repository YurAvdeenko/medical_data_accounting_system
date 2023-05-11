import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/bloc/home_bloc.dart';
import 'package:home/src/home_screen/bloc/home_event.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';

class HomeDialogWidget extends StatelessWidget {

  //todo investigate why we can handle this provider
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(
        authRepository: appDependencies.get<AuthRepository>(),
        userRepository: appDependencies.get<UserRepository>(),
      ),
      child: _HomeDialogWidgetState(),
    );
  }
}

class _HomeDialogWidgetState extends StatefulWidget {
  @override
  State<_HomeDialogWidgetState> createState() => _HomeDialogWidgetStateState();
}

class _HomeDialogWidgetStateState extends State<_HomeDialogWidgetState> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                      const Spacer(flex: 2),
                      const Text(
                        //todo add loc
                        'New Event',
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _titleController,
                        cursorColor: AppColors.darkBlue,
                        onChanged: (String? value) {
                          bloc.add(EnterDoctorEvent(value: value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Doctor',
                          labelStyle: AppTextStyle.rubicRegular12.copyWith(color: AppColors.darkBlue),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.backgroundHome,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _descriptionController,
                        cursorColor: AppColors.darkBlue,
                        onChanged: (String? value) {
                          bloc.add(EnterIllnessEvent(value: value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Illness',
                          labelStyle: AppTextStyle.rubicRegular12.copyWith(color: AppColors.darkBlue),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.backgroundHome,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _locationController,
                        cursorColor: AppColors.darkBlue,
                        onChanged: (String? value) {
                          bloc.add(EnterIllnessDescriptionEvent(value: value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: AppTextStyle.rubicRegular12.copyWith(color: AppColors.darkBlue),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.backgroundHome),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkBlue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            cursorColor: AppColors.darkBlue,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: AppTextStyle.rubicRegular12.copyWith(color: AppColors.darkBlue),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.backgroundHome),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.darkBlue),
                              ),
                            ),
                            controller: TextEditingController(
                              text: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: AppColors.violetSocial,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            bloc.add(
                              SubmitDataEvent(
                                value: Event(
                                  id: '',
                                  doctor: state.doctor ?? '',
                                  illness: state.illness ?? '',
                                  illnessDescription: state.illnessDescription ?? '',
                                  date: state.date,
                                ),
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            //todo add loc
                            'Add event',
                            style: AppTextStyle.rubicRegular12,
                          ),
                        ),
                      ),
                    ),
                    // const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final bloc = context.read<HomeBloc>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      bloc.add(EnterDateEvent(value: _selectedDate));
    }
  }
}
