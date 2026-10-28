import 'physics_quantity.dart';
import 'physics_unit.dart';

/// UI'daki her bir girdi satırının durumunu tutan model.
class InputRowModel {
  final String rowId;
  PhysicsQuantity? quantity;
  double? value;
  PhysicsUnit? selectedUnit;
  String? bodyId; // v2.0 çoklu cisim sistemleri için

  InputRowModel({
    required this.rowId,
    this.quantity,
    this.value,
    this.selectedUnit,
    this.bodyId,
  });

  /// Satırın tam ve geçerli bir girdi içerip içermediğini kontrol eder
  bool get isValid =>
      quantity != null &&
      value != null &&
      !value!.isNaN &&
      !value!.isInfinite &&
      selectedUnit != null;

  /// Kullanıcının girdiği değerin SI taban birimindeki karşılığı
  double? get normalizedSiValue {
    if (!isValid) return null;
    return selectedUnit!.toSi(value!);
  }
}
