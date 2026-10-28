import 'package:flutter_test/flutter_test.dart';
import 'package:physics_calc/engine/inference_engine.dart';
import 'package:physics_calc/models/input_row_model.dart';
import 'package:physics_calc/data/standard_quantities.dart';
import 'package:physics_calc/data/standard_units.dart';

void main() {
  group('InferenceEngine Tests', () {
    late InferenceEngine engine;

    setUp(() {
      engine = InferenceEngine();
    });

    test('Newton 2. Yasası tek adım çıkarımı (F = 10 N, m = 2 kg -> a = 5 m/s²)', () {
      final inputRows = [
        InputRowModel(
          rowId: '1',
          quantity: StandardQuantities.force,
          value: 10,
          selectedUnit: StandardUnits.findUnit('force_F', 'newton'),
        ),
        InputRowModel(
          rowId: '2',
          quantity: StandardQuantities.mass,
          value: 2,
          selectedUnit: StandardUnits.findUnit('mass_m', 'kg'),
        ),
      ];

      final result = engine.solve(inputRows);

      expect(result.allKnownValues.containsKey('accel_a'), isTrue);
      expect(result.allKnownValues['accel_a'], closeTo(5.0, 0.0001));
      expect(result.steps.length, 1);
      expect(result.steps.first.formula.targetQuantityId, 'accel_a');
    });

    test('Birim normalizasyonu ile çıkarım (v = 72 km/h, t = 5 s -> d = 100 m)', () {
      final inputRows = [
        InputRowModel(
          rowId: '1',
          quantity: StandardQuantities.velocity,
          value: 72, // 72 km/h = 20 m/s
          selectedUnit: StandardUnits.findUnit('velocity_v', 'km_h'),
        ),
        InputRowModel(
          rowId: '2',
          quantity: StandardQuantities.time,
          value: 5,
          selectedUnit: StandardUnits.findUnit('time_t', 's'),
        ),
      ];

      final result = engine.solve(inputRows);

      expect(result.allKnownValues.containsKey('distance_d'), isTrue);
      expect(result.allKnownValues['distance_d'], closeTo(100.0, 0.0001));
      // Ayrıca a = v / t = 20 / 5 = 4 m/s² de türetilmiş olmalı
      expect(result.allKnownValues['accel_a'], closeTo(4.0, 0.0001));
    });

    test('Çok adımlı zincirleme çıkarım testi (Mass, Velocity, Time verildiğinde)', () {
      final inputRows = [
        InputRowModel(
          rowId: '1',
          quantity: StandardQuantities.mass,
          value: 2,
          selectedUnit: StandardUnits.findUnit('mass_m', 'kg'),
        ),
        InputRowModel(
          rowId: '2',
          quantity: StandardQuantities.velocity,
          value: 10,
          selectedUnit: StandardUnits.findUnit('velocity_v', 'm_s'),
        ),
        InputRowModel(
          rowId: '3',
          quantity: StandardQuantities.time,
          value: 5,
          selectedUnit: StandardUnits.findUnit('time_t', 's'),
        ),
      ];

      final result = engine.solve(inputRows);

      // Beklenen türetimler:
      // Ek = 0.5 * 2 * 10^2 = 100 J
      // p = 2 * 10 = 20 kg·m/s
      // d = 10 * 5 = 50 m
      // a = 10 / 5 = 2 m/s²
      // F = 2 * 2 = 4 N
      // W = 4 * 50 = 200 J
      // P = 200 / 5 = 40 W
      expect(result.allKnownValues['energy_Ek'], closeTo(100.0, 0.0001));
      expect(result.allKnownValues['momentum_p'], closeTo(20.0, 0.0001));
      expect(result.allKnownValues['distance_d'], closeTo(50.0, 0.0001));
      expect(result.allKnownValues['accel_a'], closeTo(2.0, 0.0001));
      expect(result.allKnownValues['force_F'], closeTo(4.0, 0.0001));
      expect(result.allKnownValues['work_W'], closeTo(200.0, 0.0001));
      expect(result.allKnownValues['power_P'], closeTo(40.0, 0.0001));
      expect(result.steps.length, greaterThanOrEqualTo(6));
    });

    test('Sıfıra bölünme durumunda motor güvenle durmalı', () {
      final inputRows = [
        InputRowModel(
          rowId: '1',
          quantity: StandardQuantities.distance,
          value: 100,
          selectedUnit: StandardUnits.findUnit('distance_d', 'm'),
        ),
        InputRowModel(
          rowId: '2',
          quantity: StandardQuantities.time,
          value: 0, // Sıfır saniye
          selectedUnit: StandardUnits.findUnit('time_t', 's'),
        ),
      ];

      final result = engine.solve(inputRows);

      // v = d / t formülü time != 0 kontrolü nedeniyle çalışmamalı
      expect(result.allKnownValues.containsKey('velocity_v'), isFalse);
    });

    test('İtiş (Impulse) çıkarım testi (F = 20 N, t = 3 s -> I = 60 N·s)', () {
      final inputRows = [
        InputRowModel(
          rowId: '1',
          quantity: StandardQuantities.force,
          value: 20,
          selectedUnit: StandardUnits.findUnit('force_F', 'newton'),
        ),
        InputRowModel(
          rowId: '2',
          quantity: StandardQuantities.time,
          value: 3,
          selectedUnit: StandardUnits.findUnit('time_t', 's'),
        ),
      ];

      final result = engine.solve(inputRows);

      expect(result.allKnownValues.containsKey('impulse_I'), isTrue);
      expect(result.allKnownValues['impulse_I'], closeTo(60.0, 0.0001));
    });
  });
}
