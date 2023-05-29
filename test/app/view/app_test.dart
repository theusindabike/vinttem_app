import 'package:flutter_test/flutter_test.dart';
import 'package:vinttem_app/app/app.dart';
import 'package:vinttem_app/home/home.dart';
import 'package:vinttem_repository/vinttem_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(App(
        vinttemRepository: VinttemMockRepository(),
      ),);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
