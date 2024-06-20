import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class WidgetShowDialog {
  WidgetShowDialog._();

  static DeleteShowDialog(
      BuildContext context, String text, IconData icon, Function() function) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          icon,
          size: 36,
          color: Colors.black,
        ),
        title: Text(
          'Deseja mesmo excluir ${text}?',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              fixedSize: Size(130, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1, color: Colors.black26),
              ),
            ),
            child: Text(
              'Cancelar',
              style: TextStyle(fontSize: 18, color: Config.grey800),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              function();
            },
            style: TextButton.styleFrom(
              backgroundColor: Config.orange,
              fixedSize: Size(130, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 1, color: Config.orange),
              ),
            ),
            child: Text('Sim, excluir',
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static CustomShowDialog({
    required BuildContext context,
    required String text,
    IconData? icon,
    List<Widget>? actions,
    required List<Widget> body,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: body,
        ),
        actions: actions,
      ),
    );
  }
}
