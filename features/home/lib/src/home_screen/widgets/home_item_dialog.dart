import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class HomeItemDialogWidget extends StatefulWidget {
  final Event event;
  final void Function() delete;

  HomeItemDialogWidget({
    required this.event,
    required this.delete,
  });

  @override
  State<HomeItemDialogWidget> createState() => _HomeItemDialogWidgetState();
}

class _HomeItemDialogWidgetState extends State<HomeItemDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
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
                  Column(
                    children: <Widget>[
                      Text(
                        'general.your_event'.tr(),
                        style: AppTextStyle.rubicRegular20.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${widget.event.date?.day}/${widget.event.date?.month}/${widget.event.date?.year} at ${widget.event.date?.hour}:${widget.event.date?.minute}',
                        maxLines: 2,
                        style: AppTextStyle.rubicRegular20.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        'general.doctor'.tr(),
                        style: AppTextStyle.rubicRegular12.copyWith(
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.doctor,
                          maxLines: 2,
                          style: AppTextStyle.rubicRegularHint15.copyWith(
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1, height: 30),
                  Row(
                    children: <Widget>[
                      Text(
                        'general.illness'.tr(),
                        maxLines: 2,
                        style: AppTextStyle.rubicRegular12.copyWith(
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.illness,
                          style: AppTextStyle.rubicRegularHint15.copyWith(
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1, height: 30),
                  Row(
                    children: <Widget>[
                      Text(
                        'general.description'.tr(),
                        maxLines: 4,
                        style: AppTextStyle.rubicRegular12.copyWith(
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.illnessDescription,
                          style: AppTextStyle.rubicRegularHint15.copyWith(
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1, height: 30),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          widget.delete();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'general.delete'.tr(),
                          style: AppTextStyle.rubicRegular12.copyWith(
                            color: AppColors.violetSocial,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.violetSocial,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            widget.delete();
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text(
                              'general.back'.tr(),
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
          ],
        ),
      ),
    );
  }
}
