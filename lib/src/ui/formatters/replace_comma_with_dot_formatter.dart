import 'package:flutter/services.dart';

class ReplaceCommaWithDotFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains(',')) {
      return TextEditingValue(
        text: newValue.text.replaceAll(',', '.'),
        selection: newValue.selection,
      );
    }

    return newValue;
  }
}
