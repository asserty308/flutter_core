import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DurationExtension', () {
    test('formatHMS() formats duration correctly', () {
      expect(Duration.zero.formatHMS, '00:00:00');
      expect(const Duration(hours: 1).formatHMS, '01:00:00');
      expect(const Duration(minutes: 1).formatHMS, '00:01:00');
      expect(const Duration(seconds: 1).formatHMS, '00:00:01');
      expect(
        const Duration(hours: 1, minutes: 30, seconds: 45).formatHMS,
        '01:30:45',
      );
      expect(const Duration(hours: 100).formatHMS, '100:00:00');
    });

    test('formatHM() formats duration correctly', () {
      expect(Duration.zero.formatHM, '00:00');
      expect(const Duration(hours: 1).formatHM, '01:00');
      expect(const Duration(minutes: 30).formatHM, '00:30');
      expect(const Duration(hours: 2, minutes: 45).formatHM, '02:45');
      expect(const Duration(hours: 100).formatHM, '100:00');
    });

    test('formatMS() formats duration correctly', () {
      expect(Duration.zero.formatMS, '00:00');
      expect(const Duration(minutes: 1).formatMS, '01:00');
      expect(const Duration(seconds: 30).formatMS, '00:30');
      expect(const Duration(minutes: 2, seconds: 45).formatMS, '02:45');
      expect(const Duration(minutes: 100).formatMS, '100:00');
    });
  });
}
