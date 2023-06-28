// ignore_for_file: prefer_const_constructors
import 'package:network_client/network_client.dart';
import 'package:test/test.dart';

void main() {
  group('NetworkClient', () {
    test('can be instantiated', () {
      expect(NetworkClient(), isNotNull);
    });
  });
}
