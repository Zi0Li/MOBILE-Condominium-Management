// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class InputWidget extends StatelessWidget {
  String label;
  IconData icon;
  TextEditingController controller;
  TextInputType keyboardType;
  double? height;
  double? width;
  int? maxLine;
  bool obscureText;

  InputWidget(this.label, this.controller, this.keyboardType, this.icon,
      {super.key, this.height, this.width, this.maxLine = 1, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: height,
        width: width,
        child: TextFormField(
          validator: Config.validator,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLine,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Config.grey600,
            ),
            hintText: label,
            hintStyle: TextStyle(
              color: Config.grey400,
            ),
          ),
        ),
      ),
    );
  }
}
