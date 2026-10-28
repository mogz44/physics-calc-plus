import 'formula.dart';

/// Çözüm ağacındaki tek bir türetim adımını temsil eder.
class InferenceStep {
  final int stepIndex;
  final Formula formula;
  final String targetQuantityId;
  final double calculatedValue;
  final Map<String, double> usedInputs; // Hangi girdilerle hesaplandığı

  const InferenceStep({
    required this.stepIndex,
    required this.formula,
    required this.targetQuantityId,
    required this.calculatedValue,
    required this.usedInputs,
  });
}
