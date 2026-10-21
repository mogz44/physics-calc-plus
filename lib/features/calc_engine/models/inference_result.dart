import 'inference_step.dart';

/// Çıkarım motorunun çalışması sonucunda üretilen nihai rapor.
class InferenceResult {
  /// Başlangıçta kullanıcı tarafından doğrudan girilen SI değerler
  final Map<String, double> initialKnownValues;

  /// Çözülenler dahil olmak üzere sistemin bildiği tüm SI değerler
  final Map<String, double> allKnownValues;

  /// Adım adım türetilme sırası (Rapor ekranında gösterilecek ağaç)
  final List<InferenceStep> steps;

  /// Yeni türetilen büyüklüklerin ID listesi
  final List<String> newlyDerivedQuantityIds;

  const InferenceResult({
    required this.initialKnownValues,
    required this.allKnownValues,
    required this.steps,
    required this.newlyDerivedQuantityIds,
  });

  bool get hasDerivedValues => newlyDerivedQuantityIds.isNotEmpty;
}
