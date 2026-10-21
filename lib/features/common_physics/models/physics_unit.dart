/// Fiziksel birim ve SI dönüşüm mekanizması.
class PhysicsUnit {
  final String id;
  final String quantityId; // Hangi büyüklüğe ait olduğu (örn: 'speed_v')
  final String name;       // 'Kilometre/Saat'
  final String symbol;     // 'km/h'
  final bool isSi;         // SI taban birimi mi?
  
  final double Function(double value) toSi;
  final double Function(double siValue) fromSi;

  const PhysicsUnit({
    required this.id,
    required this.quantityId,
    required this.name,
    required this.symbol,
    required this.toSi,
    required this.fromSi,
    this.isSi = false,
  });

  /// Standart çarpan bazlı doğrusal birimler için (Örn: 1 km = 1000 m)
  factory PhysicsUnit.linear({
    required String id,
    required String quantityId,
    required String name,
    required String symbol,
    required double factorToSi,
    bool isSi = false,
  }) {
    return PhysicsUnit(
      id: id,
      quantityId: quantityId,
      name: name,
      symbol: symbol,
      isSi: isSi,
      toSi: (val) => val * factorToSi,
      fromSi: (siVal) => siVal / factorToSi,
    );
  }

  /// Ofsetli birimler için (Örn: Sıcaklık °C -> K)
  factory PhysicsUnit.offset({
    required String id,
    required String quantityId,
    required String name,
    required String symbol,
    required double factorToSi,
    required double offsetToSi,
    bool isSi = false,
  }) {
    return PhysicsUnit(
      id: id,
      quantityId: quantityId,
      name: name,
      symbol: symbol,
      isSi: isSi,
      toSi: (val) => (val * factorToSi) + offsetToSi,
      fromSi: (siVal) => (siVal - offsetToSi) / factorToSi,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhysicsUnit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          quantityId == other.quantityId;

  @override
  int get hashCode => Object.hash(id, quantityId);

  @override
  String toString() => '$name ($symbol)';
}
