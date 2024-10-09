import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomInputMask {
  static var maskPhone = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static var maskCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static var maskRg = MaskTextInputFormatter(
    mask: '##.###.###-#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static var maskTime = MaskTextInputFormatter(
    mask: '##:## até ##:##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
