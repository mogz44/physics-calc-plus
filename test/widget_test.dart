import 'package:flutter_test/flutter_test.dart';
import 'package:physics_calc/app.dart';

void main() {
  testWidgets('Physics Calc+ render smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PhysicsCalcApp());
    await tester.pumpAndSettle();

    // Verify AppBar title exists
    expect(find.text('Physics Calc+'), findsOneWidget);

    // Verify 3 bottom navigation tabs exist
    expect(find.text('Hesaplayıcı'), findsOneWidget);
    expect(find.text('Dönüştürücü'), findsOneWidget);
    expect(find.text('Ayarlar'), findsOneWidget);

    // Verify default 2 input rows exist with stacked design placeholders
    expect(find.text('Fiziksel Büyüklük Seç'), findsNWidgets(2));
    expect(find.text('Değer Ekle'), findsOneWidget);
    expect(find.text('Sonuç Raporunu Gör'), findsOneWidget);
  });
}
