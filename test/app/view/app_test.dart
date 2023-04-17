import 'package:flutter_test/flutter_test.dart';
import 'package:vinttem_app/app/app.dart';
import 'package:vinttem_app/home/home.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
