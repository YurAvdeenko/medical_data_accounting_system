import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const HomeFloatingActionButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onTap,
      backgroundColor: AppColors.violetSocial,
      label: Text(
        'general.add_new_event'.tr(),
        style: AppTextStyle.rubicRegular12.copyWith(fontSize: 16),
      ),
      icon: const Icon(Icons.add),
    );
  }
}
