// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  group('VinttemApi', () {
    test('can be instantiated', () {
      expect(VinttemRepository(), isNotNull);
    });
  });
}
