// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tcc/widgets/drawers/employee_drawer.dart';
import 'package:tcc/widgets/drawers/syndicate_drawer.dart';

class Config {
  Config._();

  static Color orange = Color.fromRGBO(255, 96, 0, 1);
  static Color light_purple = Color.fromRGBO(104, 116, 232, 1);
  static Color white = Colors.white;

  static Color black = Colors.black;
  static Color red = Colors.red;
  static Color grey_letter = Color.fromRGBO(64, 61, 56, 1);
  static Color grey400 = Colors.grey.shade400;
  static Color grey600 = Colors.grey.shade600;
  static Color grey800 = Colors.grey.shade800;
  static Color green = Color.fromRGBO(0, 128, 0, 1);
  static Color amber = Colors.amber;

  static dynamic user;

  static String sindico = "SINDICO";
  static String morador = "MORADOR";
  static String funcionario = "FUNCIONARIO";

  static final List<String> typeVehicle = [
    "Carro",
    "Moto",
    "Bicicleta",
    "Transporte"
  ];

  static String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }

  static Widget text(String label1, String label2, double fontSize) {
    return RichText(
      overflow: TextOverflow.clip,
      softWrap: true,
      maxLines: null,
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

  static String textToUtf8(String text) {
    return utf8.decode(text.codeUnits);
  }

  static String logoName(String name) {
    List<String> aux = name.split(' ');
    String logoName = aux.first[0];
    logoName += aux.last[0];
    return logoName;
  }

  static String passwordEmployee(String cpf, String rg) {
    String password = '';
    if (cpf.isNotEmpty && rg.isNotEmpty) {
      cpf = cpf.replaceAll('.', '').replaceAll('-', '');
      rg = rg.replaceAll('.', '').replaceAll('-', '');
      password += cpf.substring(0, 4);
      password += rg.substring(rg.length - 4, rg.length);
    }
    return password;
  }

  static Widget managersDrawer(){
    if (user.role == funcionario) {
      return EmployeeDrawerApp();
    } else {
      return SyndicateDrawerApp();
    }
  }
}
