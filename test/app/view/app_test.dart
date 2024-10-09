import 'package:flutter_test/flutter_test.dart';
import 'package:habit_away/app/app.dart';
import 'package:habit_away/app/view/app_view.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const AppView());
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
