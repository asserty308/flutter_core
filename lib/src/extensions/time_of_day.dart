import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  /// Formats this instance to [pattern].
  String formatToPattern([String pattern = 'HH:mm']) {
    final dt = DateTime(2000, 1, 1, hour, minute);
    return DateFormat(pattern).format(dt);
  }

  String get hhMM => formatToPattern('HH:mm');
}

extension TimeOfDayString on String {
  TimeOfDay? parseTimeOfDay() {
    if (isEmpty) {
      return null; // Return null if the string is null or empty
    }

    try {
      final parts = split(':');
      if (parts.length != 2) {
        throw FormatException('Invalid time format');
      }

      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
        throw FormatException('Time values out of range');
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return null; // Return null if parsing fails
    }
  }
}
