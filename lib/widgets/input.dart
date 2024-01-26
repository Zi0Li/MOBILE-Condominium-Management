// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class InputWidget extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType;

  InputWidget(this.label, this.controller, this.keyboardType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Config.dark_purple,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: TextFormField(
              validator: Config.validator,
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Config.dark_purple),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}