import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isToday', () {
    final now = DateTime.now();
    final year1990 = now.copyWith(year: 1990);
    final otherDay = now.subtract(const Duration(days: 10));
    expect(now.isToday(), true);
    expect(now.isToday(false), true);
    expect(year1990.isToday(), false);
    expect(year1990.isToday(false), true);
    expect(otherDay.isToday(), false);
    expect(otherDay.isToday(false), false);
  });

  test('isSameDay', () {
    final date1 = DateTime(2024, 4, 1);
    final date2 = DateTime(2024, 4, 1);
    final date3 = DateTime(2023, 4, 1);
    final date4 = DateTime(2023, 5, 1);

    expect(date1.isSameDay(date2), true);
    expect(date1.isSameDay(date3), true);
    expect(date1.isSameDay(date3, true), false);
    expect(date1.isSameDay(date4), false);
  });

  test('ageToday', () {
    final date = DateTime(2000, 1, 1);
    final age = DateTime.now().year - date.year;
    expect(date.ageToday, age);
  });

  test('ageToday future date', () {
    final date = DateTime(2050, 1, 1);
    expect(date.ageToday, 0);
  });

  test('ageToday past date', () {
    final birthdate = DateTime(2000, 1, 1);
    final age = DateTime.now().year - birthdate.year;
    expect(birthdate.ageToday, age);
  });

  test('numOfCalendarWeeks returns correct number of weeks for a given year', () {
    expect(DateTime(2020).numOfCalendarWeeks, 53);
    expect(DateTime(2021).numOfCalendarWeeks, 52);
    expect(DateTime(2022).numOfCalendarWeeks, 52);
    expect(DateTime(2023).numOfCalendarWeeks, 52);
    expect(DateTime(2024).numOfCalendarWeeks, 52);
    expect(DateTime(2025).numOfCalendarWeeks, 52);
    expect(DateTime(2026).numOfCalendarWeeks, 53);
    expect(DateTime(2027).numOfCalendarWeeks, 52);
    expect(DateTime(2028).numOfCalendarWeeks, 52);
    expect(DateTime(2029).numOfCalendarWeeks, 52);
    expect(DateTime(2030).numOfCalendarWeeks, 52);
    expect(DateTime(2031).numOfCalendarWeeks, 52);
    expect(DateTime(2032).numOfCalendarWeeks, 53);
    expect(DateTime(2037).numOfCalendarWeeks, 53);
  });

  test('weekNumber returns correct week number from a given date', () {
    expect(DateTime(2020, 12, 28).weekNumber, 53);
    expect(DateTime(2021, 1, 1).weekNumber, 53);
    expect(DateTime(2021, 1, 2).weekNumber, 53);
    expect(DateTime(2021, 1, 4).weekNumber, 1);
    expect(DateTime(2021, 12, 28).weekNumber, 52);
  });

  test('getStartOfWeek returns correct start of week for a given date', () {
    expect(DateTime(2020, 12, 28).startOfWeek, DateTime(2020, 12, 28));
    expect(DateTime(2021, 1, 1).startOfWeek, DateTime(2020, 12, 28));
  });

  test('getEndOfWeek returns correct end of week for a given date', () {
    expect(DateTime(2020, 12, 28).endOfWeek, DateTime(2021, 1, 3));
    expect(DateTime(2021, 1, 1).endOfWeek, DateTime(2021, 1, 3));
  });

  test('format date to String', () {
    final date = DateTime(2023, 10, 27);
    expect(date.formatDate('yyyy-MM-dd'), '2023-10-27');
  });

  test('format date-time to String', () {
    final date = DateTime(2023, 10, 27, 11, 0, 0);
    expect(date.formatSQLDateTime(), '2023-10-27 11:00:00');
  });

  test('Test days in between', () {
    final from = DateTime(2023, 1, 1);
    final to = DateTime(2023, 1, 5);

    final expectedDays = [
      DateTime(2023, 1, 1),
      DateTime(2023, 1, 2),
      DateTime(2023, 1, 3),
      DateTime(2023, 1, 4),
      DateTime(2023, 1, 5),
    ];

    final betweenDays = from.daysBetween(to);

    expect(betweenDays, expectedDays);
  });
}
