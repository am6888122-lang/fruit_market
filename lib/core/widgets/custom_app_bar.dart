import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF6FAE3D),
      elevation: 0,
      centerTitle: centerTitle,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              onPressed: () => Get.back(),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
