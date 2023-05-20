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
                        //todo add loc
                        'Your Event',
                        style: AppTextStyle.rubicRegular20.copyWith(fontSize: 16),
                      ),
                      Text(
                        //todo add loc
                        '${widget.event.date}',
                        maxLines: 2,
                        style: AppTextStyle.rubicRegular20.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
                      const Text(
                        'Doctor: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.doctor,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1),
                  // const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Illness: ',
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.illness,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1),
                  // const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Description: ',
                        maxLines: 4,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.event.illnessDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.bordersHome, thickness: 1),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          widget.delete();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete',
                          style: AppTextStyle.rubicRegular20.copyWith(
                            fontSize: 16,
                            color: AppColors.violetSocial,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.violetSocial,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        //todo add loc
                        child: const Text('Back'),
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
