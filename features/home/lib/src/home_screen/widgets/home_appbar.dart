import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onSignOut;

  const HomeAppBar({
    Key? key,
    required this.title,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: AppColors.violetSocial,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout, size: 20),
          onPressed: onSignOut,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}