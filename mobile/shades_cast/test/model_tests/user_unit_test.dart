import 'package:shades_cast/domain_layer/user.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('User properties should have correct values', () {
      final user = User(
        id: 1,
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
      );

      expect(user.id, equals(1));
      expect(user.name, equals('John Doe'));
      expect(user.email, equals('john@example.com'));
      expect(user.password, equals('password123'));
    });
  });
}
