// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tcc/widgets/config.dart';

class InputWidget extends StatefulWidget {
  String label;
  IconData icon;
  TextEditingController controller;
  TextInputType keyboardType;
  double? height;
  double? width;
  int? maxLine;
  int? minLine;
  bool obscureText;
  bool enabled;
  Function()? function;

  InputWidget(
    this.label,
    this.controller,
    this.keyboardType,
    this.icon, {
    this.height,
    this.width,
    this.maxLine = 1,
    this.minLine = 1,
    this.obscureText = false,
    this.enabled = true,
    this.function,
    super.key,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  IconData iconSuffix = Icons.remove_red_eye_outlined;
  late bool _withSuffix;

  @override
  void initState() {
    super.initState();
    _withSuffix = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          onTap: widget.function,
          enabled: widget.enabled,
          validator: Config.validator,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLine,
          minLines: widget.minLine,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            suffixIcon: (_withSuffix)
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.obscureText = widget.obscureText ? false : true;
                        iconSuffix = widget.obscureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined;
                      });
                    },
                    child: Icon(
                      iconSuffix,
                      color: Config.grey400,
                    ),
                  )
                : null,
            prefixIcon: Icon(
              widget.icon,
              color: Config.grey600,
            ),
            label: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
