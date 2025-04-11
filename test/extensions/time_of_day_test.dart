import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/extensions/time_of_day.dart';

void main() {
  group('TimeOfDayExtension', () {
    test('formatToPattern with default pattern', () {
      final time = TimeOfDay(hour: 14, minute: 30);
      expect(time.formatToPattern(), '14:30');
    });

    test('formatToPattern with custom pattern', () {
      final time = TimeOfDay(hour: 14, minute: 30);
      expect(time.formatToPattern('h:mm a'), '2:30 PM');
    });

    test('hhMM getter', () {
      final time = TimeOfDay(hour: 9, minute: 5);
      expect(time.hhMM, '09:05');
    });

    test('various times of day', () {
      expect(TimeOfDay(hour: 0, minute: 0).formatToPattern(), '00:00');
      expect(TimeOfDay(hour: 12, minute: 0).formatToPattern(), '12:00');
      expect(TimeOfDay(hour: 23, minute: 59).formatToPattern(), '23:59');
    });
  });

  group('TimeOfDayString', () {
    test('valid time string parsing', () {
      final result = '14:30'.parseTimeOfDay();
      expect(result?.hour, 14);
      expect(result?.minute, 30);
    });

    test('empty string returns null', () {
      expect(''.parseTimeOfDay(), null);
    });

    group('invalid formats', () {
      test('wrong separator', () {
        expect('14.30'.parseTimeOfDay(), null);
        expect('14-30'.parseTimeOfDay(), null);
      });

      test('missing parts', () {
        expect('14:'.parseTimeOfDay(), null);
        expect(':30'.parseTimeOfDay(), null);
        expect('14'.parseTimeOfDay(), null);
      });

      test('non-numeric values', () {
        expect('ab:cd'.parseTimeOfDay(), null);
        expect('1a:30'.parseTimeOfDay(), null);
      });
    });

    group('out of range values', () {
      test('invalid hours', () {
        expect('24:00'.parseTimeOfDay(), null);
        expect('-1:00'.parseTimeOfDay(), null);
      });

      test('invalid minutes', () {
        expect('12:60'.parseTimeOfDay(), null);
        expect('12:-1'.parseTimeOfDay(), null);
      });
    });

    group('edge cases', () {
      test('midnight', () {
        final result = '00:00'.parseTimeOfDay();
        expect(result?.hour, 0);
        expect(result?.minute, 0);
      });

      test('last minute of day', () {
        final result = '23:59'.parseTimeOfDay();
        expect(result?.hour, 23);
        expect(result?.minute, 59);
      });

      test('leading zeros', () {
        final result = '09:05'.parseTimeOfDay();
        expect(result?.hour, 9);
        expect(result?.minute, 5);
      });
    });
  });
}
