import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/main.dart';

void main() {
  testWidgets('News test', (WidgetTester tester) async {
    await tester.pumpWidget(NewsApp());

    expect(find.text('News 24x7'), findsOneWidget);
  });
}
