import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  // Access to MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get mediaPadding => mediaQuery.padding;

  // Access to Theme
  ThemeData get theme => Theme.of(this);

  // Access to ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  // Access to TextTheme
  TextTheme get textTheme => theme.textTheme;

  // Orientation shortcut
  Orientation get orientation => mediaQuery.orientation;

  // Screen size shortcuts
  Size get mediaSize => MediaQuery.sizeOf(this);
  double get screenWidth => mediaSize.width;
  double get screenHeight => mediaSize.height;

  // Access to focus scpoe
  FocusScopeNode get focusScope => FocusScope.of(this);

  void dismissKeyboard() {
    if (!focusScope.hasPrimaryFocus) {
      focusScope.unfocus();
    }
  }
}
