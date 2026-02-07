import 'package:flutter_test/flutter_test.dart';

import 'package:safe_house/main.dart';

void main() {
  testWidgets('SafeHouseApp renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SafeHouseApp());

    // Splash screen should show SafeHouse text
    expect(find.text('SafeHouse'), findsOneWidget);

    // Advance past splash timer to avoid pending timer error
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
