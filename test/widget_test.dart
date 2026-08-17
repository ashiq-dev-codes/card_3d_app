import 'package:card_3d_app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductPage renders the hero copy', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Dynamic\n3D Flip Animation'), findsOneWidget);
    expect(find.text('InterfaceMage'), findsOneWidget);
  });
}
