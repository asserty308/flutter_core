import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  /// Formats this instance to [pattern].
  String formatToPattern([String pattern = 'HH:mm']) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, hour, minute);
    return DateFormat(pattern).format(dt); 
  }
}
