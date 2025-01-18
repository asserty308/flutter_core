import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension MyDateTime on DateTime {
  /// Converts the given [seconds] since epoch to a DateTime object.
  static DateTime fromSecondsSinceEpoch(int seconds) => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  /// Returns true when this is the same day as [date]
  /// When [checkYear] is true the year is included which means that the date must be on the same year.
  /// When [checkYear] is false, the date must not be on the same year but on the same day.
  bool isSameDay(DateTime date, [bool checkYear = false]) {
    return day == date.day && month == date.month && (checkYear ? year == date.year : true);
  }

  /// Same as [isSameDay] but for DateTime.now().
  bool isToday([bool checkYear = true]) => isSameDay(DateTime.now(), checkYear);

  /// Returns the time in years from the given date until today.
  int get ageToday {
    final currentDate = DateTime.now();
    final month1 = currentDate.month;
    final month2 = month;

    var age = currentDate.year - year;

    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = day;
      
      if (day2 > day1) {
        age--;
      }
    }

    return max(0, age);
  }

  /// Calculates number of weeks for a given year as per https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
  int get numOfCalendarWeeks {
    // Dec 28 is always in the last week of the year
    final dec28 = DateTime(year, 12, 28);
    final dayOfDec28 = int.parse(DateFormat('D').format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int get weekNumber {
    final dayOfYear = int.parse(DateFormat('D').format(_local));
    var woy =  ((dayOfYear - weekday + 10) / 7).floor();

    if (woy < 1) {
      woy = copyWith(year: year-1).numOfCalendarWeeks;
    } else if (woy > numOfCalendarWeeks) {
      woy = 1;
    }

    return woy;
  }

  /// Returns the start of the hour.
  DateTime get startOfHour => DateTime(year, month, day, hour);

  /// Returns the start of the day, where all time related arguments are zero.
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the start of the week for this DateTime.
  DateTime get startOfWeek => subtract(Duration(days: weekday - 1)).startOfDay;

  /// Returns the end of the week for this DateTime.
  DateTime get endOfWeek => add(Duration(days: DateTime.daysPerWeek - weekday));

  /// Returns the start of the month for this DateTime.
  DateTime get startOfMonth => DateTime(year, month, 1);

  DateTime get endOfLastMonth => DateTime(year, month - 1).endOfMonth;

  /// Returns the start of the next month for this DateTime.
  DateTime get startOfNextMonth => DateTime(year, month + 1, 1);

  DateTime get startOfLastMonth => DateTime(year, month - 1, 1);

  /// Returns the end of the month for this DateTime.
  DateTime get endOfMonth => startOfNextMonth.subtract(const Duration(days: 1));

  /// Updates the date components of this DateTime with the given [date].
  DateTime setDate(DateTime date) => copyWith(year: date.year, month: date.month, day: date.day);

  /// Sets the time of day for this DateTime to the given [time].
  DateTime setTimeOfDay(TimeOfDay time) => startOfDay.copyWith(hour: time.hour, minute: time.minute);

  /// True when the weekday is a saturday or sunday. 
  bool get isWeekend => weekday > 5;

  /// Returns the difference between now and this.
  /// 
  /// Positive for future dates, negative for past dates and zero for today.
  int get daysFromNow => (difference(DateTime.now()).inHours / 24.0).ceil();

  /// Returns the number of days in the month for this DateTime.
  int get daysOfMonth => startOfNextMonth.difference(startOfMonth).inDays;

  /// Returns a list of all days in the month for this DateTime.
  List<DateTime> get daysOfMonthList => List.generate(daysOfMonth, (index) => DateTime(year, month, index + 1));

  /// Returns a list of all weekdays in the month for this DateTime.
  Iterable<DateTime> get weekdaysOfMonthList => daysOfMonthList.where((day) => !day.isWeekend);

  List<DateTime> daysBetween(DateTime to) {
    final days = <DateTime>[];
    const oneDay = Duration(days: 1);

    for (var day = startOfDay; day.isBefore(to.add(oneDay)); day = day.add(oneDay)) {
      days.add(day);
    }

    return days;
  }

  /// Returns the number of months from this DateTime until the given [to] DateTime.
  int monthsUntil(DateTime to) {
    final yearDiff = to.year - year;
    final monthDiff = to.month - month;

    return yearDiff * 12 + monthDiff;
  }

  /// Returns true if this DateTime is in the same month as the given [date].
  bool isSameMonth(DateTime date) => month == date.month && year == date.year;

  /// Returns a string representation of the date using the specified [format].
  String formatDate(String format) => DateFormat(format).format(_local);

  /// Returns a string representation of the date using the SQL Date format.
  String formatSQLDate() => formatDate('yyyy-MM-dd');

  /// Returns a string representation of the date using the SQL DateTime format.
  String formatSQLDateTime({bool withSeconds = true}) => formatDate('yyyy-MM-dd HH:mm${withSeconds ? ':ss' : ''}');

  /// Returns the date as dd.MM.yyyy.
  /// 
  /// Example: 01.01.2025
  String get dMy => DateFormat('dd.MM.yyyy').format(this);

  /// Representation of the date with fully written month.
  /// Uses the app's locale.
  /// 
  /// Example for de_DE: Juli 1996
  /// Example for en_US: July, 1996
  String get yMMMM => DateFormat.yMMMM().format(_local);

  /// Representation of the date with numeric month.
  /// Uses the app's locale.
  /// 
  /// Example for de_DE: 10.06.1996
  /// Example for en_US: 06/10/1996
  String get yMd => DateFormat.yMd().format(_local);

  /// Example: 01.01.2024
  String get ddMMyyyy => formatDate('dd.MM.yyyy');

  /// Representation of the date with abbreviated month.
  /// Uses the app's locale.
  /// 
  /// Example for de_DE: 10. Jan 1996
  /// Example for en_US: Jan 10, 1996
  String get yMMMd => DateFormat.yMMMd().format(_local);

  /// Representation of the date with fully written month.
  /// Uses the app's locale.
  /// 
  /// Example for de_DE: 8. Juli 1996
  /// Example for en_US: July 8, 1996
  String get yMMMMd => DateFormat.yMMMMd().format(_local);

  /// Representation of the time in the app's locale.
  /// 
  /// Example for de_DE: 14:20
  /// Example for en_US: 2:20 PM
  String get jm => DateFormat.jm().format(_local);

  /// Representation of the time including seconds in the app's locale.
  /// 
  /// Example for de_DE: 14:20:30
  /// Example for en_US: 2:20:30 PM
  String get jms => DateFormat.jms().format(_local);

  /// Example: 08:30
  String get hhmm => formatDate('HH:mm');

  /// Example: 08:30:45
  String get hhmmss => formatDate('HH:mm:ss');

  /// Representation of the date including the full length name of the day of week.
  /// 
  /// Example for de_DE: Montag, 22. April 2024
  /// Example for en_US: Monday April 22, 2024
  String get yMMMMEEEEd => DateFormat.yMMMMEEEEd().format(_local);

  /// Representation of the date including the full length name of the day of week.
  /// 
  /// Example for de_DE: Montag, 22. April
  /// Example for en_US: Monday April 22
  String get mmmmEEEEd => DateFormat.MMMMEEEEd().format(_local);

  String get yMdjm => DateFormat.yMd().add_jm().format(_local);

  String get yMdjms => DateFormat.yMd().add_jms().format(_local);

  /// Overloaded less than operator. Returns true if this DateTime is before [other].
  bool operator <(DateTime other) => isBefore(other);

  /// Overloaded greater than operator. Returns true if this DateTime is after [other].
  bool operator >(DateTime other) => isAfter(other);

  /// Overloaded less than or equal to operator. Returns true if this DateTime is at the same moment as or before [other].
  bool operator <=(DateTime other) => isAtSameMomentAs(other) || isBefore(other);

  /// Overloaded greater than or equal to operator. Returns true if this DateTime is at the same moment as or after [other].
  bool operator >=(DateTime other) => isAtSameMomentAs(other) || isAfter(other);

  DateTime get _local => toLocal();
}

extension MyDateFormat on String {
  DateTime? get dMy => DateFormat('dd.MM.yyyy').tryParse(this);
}
