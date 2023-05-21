import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeAddDialogWidget extends StatefulWidget {
  final void Function(
    String doctor,
    String illness,
    String illnessDescription,
    DateTime date,
  ) submit;

  HomeAddDialogWidget({required this.submit});

  @override
  State<HomeAddDialogWidget> createState() => _HomeAddDialogWidgetState();
}

class _HomeAddDialogWidgetState extends State<HomeAddDialogWidget> {
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _illnessController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

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
                    controller: _doctorController,
                    cursorColor: AppColors.darkBlue,
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
                    controller: _illnessController,
                    cursorColor: AppColors.darkBlue,
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
                    controller: _descriptionController,
                    cursorColor: AppColors.darkBlue,
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
                          labelStyle: AppTextStyle.rubicRegular12.copyWith(
                            color: AppColors.darkBlue,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.backgroundHome,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.darkBlue,
                            ),
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        widget.submit(
                          _doctorController.text,
                          _illnessController.text,
                          _descriptionController.text,
                          _selectedDate,
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.violetSocial,
              onPrimary: AppColors.white,
              onSurface: AppColors.violetSocial,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                surfaceTintColor: AppColors.violetSocial,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
