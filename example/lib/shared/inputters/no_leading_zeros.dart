import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoLeadingZeros extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text.startsWith('0') && newValue.text.length > 1) {
      return const TextEditingValue().copyWith(
        text: newValue.text.replaceAll(RegExp(r'^0+(?=.)'), ''),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.text.length - 1,
          extentOffset: newValue.text.length - 1,
        ),
      );
    } else {
      return newValue;
    }
  }
}