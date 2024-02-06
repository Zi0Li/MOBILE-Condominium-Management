// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Config {
  Config._();

  static Color backgroundColor = Colors.white;
  static Color orange = Color.fromRGBO(255, 96, 0, 1);
  static Color dark_purple = Color.fromRGBO(54, 48, 98, 1);
  static Color light_purple = Color.fromRGBO(77, 76, 125, 1);
  static Color white = Colors.white;
  static Color white_background = Color.fromRGBO(248, 247, 243, 1);
  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color grey_letter = Color.fromRGBO(64, 61, 56, 1);
  static Color grey400 = Colors.grey.shade400;
  static Color grey600 = Colors.grey.shade600;
  static Color grey800 = Colors.grey.shade800;

  static final block = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
  ];
  static final Apartment = [
    '101',
    '102',
    '103',
    '104',
    '201',
    '202',
    '203',
    '204',
    '301',
    '302',
    '303',
    '304',
    '401',
    '402',
    '403',
    '404',
  ];

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

  static Widget text(String label1, String label2, double fontSize) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 1,
      text: TextSpan(
        text: label1,
        style: TextStyle(
          color: grey_letter,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: label2,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  static String randomNumber({int qty = 10}) {
    Random _random = Random();
    int randomNumber(int min, int max) => min + _random.nextInt(max - min);
    int from, to;
    String random = '';

    from = 0;
    to = 9;

    for (int i = 0; i < qty; i++) {
      int selectedNumber = randomNumber(from, to);
      random += selectedNumber.toString();
      if (i == (qty/2)-1) {
        random += ' - ';
      }
    }

    return random;
  }
}
