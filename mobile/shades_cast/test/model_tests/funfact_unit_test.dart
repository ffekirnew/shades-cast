import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:test/test.dart';

void main() {
  group('Funfact', () {
    test('toMap() should return the funfact data as a map', () {
      final funfact = Funfact(
        title: 'Interesting Fact',
        body: 'Did you know...',
      );

      final result = funfact.toMap();

      expect(
          result,
          equals({
            'title': 'Interesting Fact',
            'body': 'Did you know...',
          }));
    });

    test('fromMap() should create a Funfact instance from a map', () {
      final funfactData = {
        'title': 'Interesting Fact',
        'body': 'Did you know...',
      };

      final funfact = Funfact.fromMap(funfactData);

      expect(funfact.title, equals('Interesting Fact'));
      expect(funfact.body, equals('Did you know...'));
    });
  });
}
