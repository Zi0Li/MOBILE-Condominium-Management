// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Config {
  Config._();

  static Color backgroundColor = Colors.white;
  static Color orange = Color.fromRGBO(249, 148, 23, 1);
  static Color dark_purple = Color.fromRGBO(54, 48, 98, 1);
  static Color light_purple = Color.fromRGBO(77, 76, 125, 1);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color grey400 = Colors.grey.shade400;
  static Color grey600 = Colors.grey.shade600;
  static Color grey800 = Colors.grey.shade800;


  static String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }

  static var maskPhone = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  
  static var maskNull = MaskTextInputFormatter();
}
