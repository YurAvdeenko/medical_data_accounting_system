import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/widgets/home_item_dialog.dart';

class HomeItemWidget extends StatelessWidget {
  final String doctor;
  final String date;
  final String illness;
  final String illnessDescription;

  const HomeItemWidget({
    Key? key,
    required this.doctor,
    required this.date,
    required this.illness,
    required this.illnessDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HomeItemDialogWidget(
              doctor: doctor,
              illness: '',
              illnessDescription: '',
              date: date,
            );
          },
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.bordersHome,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              doctor,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
