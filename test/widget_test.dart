import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/screens/app/app.dart';

void main() {
  testWidgets('test', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());
  });
}
