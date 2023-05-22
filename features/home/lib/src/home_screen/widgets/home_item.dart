import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:home/src/home_screen/widgets/home_item_dialog.dart';

class HomeItemWidget extends StatelessWidget {
  final Event event;
  final void Function() delete;

  const HomeItemWidget({
    Key? key,
    required this.event,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HomeItemDialogWidget(
              event: event,
              delete: delete,
            );
          },
        );
      },
      child: Container(
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
            Expanded(
              child: Text(
                event.illness,
                maxLines: 2,
                style: AppTextStyle.rubicRegular12.copyWith(
                  color: AppColors.darkBlue,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            Text(
              '${event.date?.day}/${event.date?.month}/${event.date?.year}',
              maxLines: 2,
              style: AppTextStyle.rubicRegularHint15.copyWith(
                color: AppColors.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
