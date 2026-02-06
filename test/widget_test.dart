import 'package:flutter_test/flutter_test.dart';

import 'package:safe_house/main.dart';

void main() {
  testWidgets('SafeHouseApp renders', (WidgetTester tester) async {
    await tester.pumpWidget(const SafeHouseApp());
    await tester.pump();

    // App should render without errors
    expect(find.text('SafeHouse'), findsOneWidget);
  });
}
