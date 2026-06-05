import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
      title: Text(title),
      automaticallyImplyLeading: showBack,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(kToolbarHeight);
}