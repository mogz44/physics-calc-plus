import 'physics_category.dart';

/// Fiziksel büyüklük modeli (Örn: Kuvvet, Kütle, İş, Güç vb.)
/// Çakışmaları önlemek için sembol yerine benzersiz [id] kullanılır.
/// TR/EN çoklu dil ve v2.0 için [bodyId] desteği mevcuttur.
class PhysicsQuantity {
  final String id;
  final String name;       // Türkçe adı
  final String? nameEn;    // İngilizce adı
  final String symbol;
  final String icon;
  final PhysicsCategory category;
  final String defaultUnitId;
  final String? bodyId;    // v2.0 çoklu cisim desteği için (örn: 'body_1', 'body_2')

  const PhysicsQuantity({
    required this.id,
    required this.name,
    this.nameEn,
    required this.symbol,
    required this.icon,
    required this.category,
    required this.defaultUnitId,
    this.bodyId,
  });

  /// Dil koduna göre lokalize edilmiş ad döner ('tr' veya 'en')
  String getLocalizedName(String langCode) {
    if (langCode == 'en' && nameEn != null && nameEn!.isNotEmpty) {
      return nameEn!;
    }
    return name;
  }

  /// UI gösterimi: "💼 İş (W)" veya cisim varsa "💼 [Cisim 1] İş (W)"
  String displayName([String langCode = 'tr']) {
    final localized = getLocalizedName(langCode);
    if (bodyId != null && bodyId!.isNotEmpty) {
      return '$icon [$bodyId] $localized ($symbol)';
    }
    return '$icon $localized ($symbol)';
  }

  PhysicsQuantity copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? symbol,
    String? icon,
    PhysicsCategory? category,
    String? defaultUnitId,
    String? bodyId,
  }) {
    return PhysicsQuantity(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      symbol: symbol ?? this.symbol,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      defaultUnitId: defaultUnitId ?? this.defaultUnitId,
      bodyId: bodyId ?? this.bodyId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhysicsQuantity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bodyId == other.bodyId;

  @override
  int get hashCode => Object.hash(id, bodyId);

  @override
  String toString() => displayName('tr');
}
