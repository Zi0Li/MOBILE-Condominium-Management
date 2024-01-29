import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Config.dark_purple,
      toolbarHeight: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
