import 'package:test/test.dart';

void main() {
  group('durationToString', () {
    test('converts duration to string correctly', () {
      final duration = Duration(hours: 2, minutes: 30, seconds: 45);
      final result = durationToString(duration);
      expect(result, equals('02:30:45'));
    });

    // Add more test cases to cover different scenarios
  });
}

String durationToString(Duration duration) {
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  int hours = duration.inHours.remainder(60);
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
