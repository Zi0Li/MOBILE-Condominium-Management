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
          Icons.delete_forever,
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
}
