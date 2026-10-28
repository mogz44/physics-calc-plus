import '../data/standard_formulas.dart';
import '../models/formula.dart';
import '../models/inference_result.dart';
import '../models/inference_step.dart';
import '../models/input_row_model.dart';

/// Physics Calc+ Çıkarım Motoru (Inference Engine).
/// Bilinen büyüklükleri ve açık türevli formülleri kullanarak zincirleme
/// bir çıkarım ağı kurar ve türetilebilen tüm değerleri adım adım çözer.
class InferenceEngine {
  final List<Formula> formulas;

  InferenceEngine({List<Formula>? formulas})
      : formulas = formulas ?? StandardFormulas.all;

  /// Kullanıcının girdiği satırları alır, normalize eder ve çıkarım döngüsünü işletir.
  InferenceResult solve(List<InputRowModel> inputRows) {
    // 1. Geçerli kullanıcı girdilerini al ve SI birimlerine dönüştür
    final Map<String, double> knownValues = {};
    for (final row in inputRows) {
      if (row.isValid) {
        final qId = row.quantity!.id;
        final siVal = row.normalizedSiValue!;
        knownValues[qId] = siVal;
      }
    }

    final initialValues = Map<String, double>.from(knownValues);
    final List<InferenceStep> steps = [];
    final List<String> newlyDerivedIds = [];

    bool newDataFound = true;
    int maxIterations = 100; // Sonsuz döngü koruması
    int stepCounter = 1;

    // 2. Zincirleme çıkarım döngüsü
    while (newDataFound && maxIterations > 0) {
      newDataFound = false;
      maxIterations--;

      for (final formula in formulas) {
        // Hedef büyüklük zaten biliniyorsa hesaplamaya gerek yok
        if (knownValues.containsKey(formula.targetQuantityId)) {
          continue;
        }

        // Formül için gereken tüm girdiler bilinenler arasında var mı?
        final bool hasAllInputs = formula.requiredQuantityIds.every(
          (reqId) => knownValues.containsKey(reqId),
        );

        if (!hasAllInputs) {
          continue;
        }

        // Kısıt / matematiksel geçerlilik kontrolü (Sıfıra bölünme, negatif karekök vb.)
        if (formula.isValid(knownValues)) {
          final double calculated = formula.calculate(knownValues);

          // Sayısal geçerlilik kontrolü (NaN veya Infinite değilse)
          if (!calculated.isNaN && !calculated.isInfinite) {
            knownValues[formula.targetQuantityId] = calculated;
            newlyDerivedIds.add(formula.targetQuantityId);

            steps.add(InferenceStep(
              stepIndex: stepCounter++,
              formula: formula,
              targetQuantityId: formula.targetQuantityId,
              calculatedValue: calculated,
              usedInputs: {
                for (final id in formula.requiredQuantityIds)
                  id: knownValues[id]!,
              },
            ));

            // Yeni bir veri bulunduğundan döngü devam etmeli
            newDataFound = true;
          }
        }
      }
    }

    return InferenceResult(
      initialKnownValues: initialValues,
      allKnownValues: knownValues,
      steps: steps,
      newlyDerivedQuantityIds: newlyDerivedIds,
    );
  }
}
