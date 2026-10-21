import 'package:flutter_test/flutter_test.dart';
import 'package:physics_calc/app.dart';

void main() {
  testWidgets('Physics Calc+ render smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PhysicsCalcApp());
    await tester.pumpAndSettle();

    // Verify app bar title and bottom navigation label exist
    expect(find.text('Physics Calc+'), findsNWidgets(2));
    // Verify default 2 input rows exist ("Büyüklük Seç" placeholder or similar)
    expect(find.text('Değer Ekle'), findsOneWidget);
    expect(find.text('Sonuç Raporunu Gör'), findsOneWidget);
  });
}
