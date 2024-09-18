// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  double? height;
  String? title;
  Color? backgroundColor;
  List<Widget>? actions;
  AppBarWidget({
    super.key,
    this.height = 56,
    this.title = '',
    this.backgroundColor = Colors.white,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: height,
      actions: actions,
      title: Text(
        title!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Config.orange,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
