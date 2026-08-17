import 'dart:ui';

import 'package:card_3d_app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductPage renders the hero copy', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const App());

    expect(find.text('Dynamic\n3D Flip Animation'), findsOneWidget);
    expect(find.text('SHOES'), findsWidgets);
  });
}
