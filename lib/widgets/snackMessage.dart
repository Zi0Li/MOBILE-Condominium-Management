import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class WidgetSnackMessage {
  WidgetSnackMessage._();

  static notificationSnackMessage(
      {required BuildContext? context,
      required String? mensage,
      required Color? backgroundColor,
      IconData? icon}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: Config.white,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              mensage!,
              style: TextStyle(
                overflow: TextOverflow.clip,
                color: Config.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: Config.white,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}
