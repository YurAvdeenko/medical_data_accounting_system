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
      //todo add loc
      label: const Text('Add new event'),
      icon: const Icon(Icons.add),
    );
  }
}
