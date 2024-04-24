import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class WidgetLoading {
  WidgetLoading._();

  static containerLoading() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Carregando',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator(
            color: Config.orange,
          ),
        ],
      ),
    );
  }
}
