/// Fizik çıkarım motorundaki her bir formül türevi (TR/EN dil destekli).
class Formula {
  final String id;                        // 'newton_2nd_a'
  final String groupName;                 // 'Newton 2. Yasası'
  final String? groupNameEn;              // 'Newton\'s 2nd Law'
  final String description;              // 'İvme Hesabı'
  final String? descriptionEn;           // 'Acceleration Calculation'
  final String latex;                     // 'a = F / m'
  final String targetQuantityId;          // 'accel_a'
  final List<String> requiredQuantityIds; // ['force_F', 'mass_m']

  /// Sıfıra bölünme, negatif karekök vb. matematiksel / fiziksel kısıt kontrolleri
  final bool Function(Map<String, double> siInputs) isValid;

  /// Değeri hesaplayan ana fonksiyon (Tüm girdiler SI biriminde gelir, SI döner)
  final double Function(Map<String, double> siInputs) calculate;

  const Formula({
    required this.id,
    required this.groupName,
    this.groupNameEn,
    required this.description,
    this.descriptionEn,
    required this.latex,
    required this.targetQuantityId,
    required this.requiredQuantityIds,
    required this.calculate,
    this.isValid = _defaultValid,
  });

  String getLocalizedGroupName(String langCode) {
    if (langCode == 'en' && groupNameEn != null && groupNameEn!.isNotEmpty) {
      return groupNameEn!;
    }
    return groupName;
  }

  String getLocalizedDescription(String langCode) {
    if (langCode == 'en' && descriptionEn != null && descriptionEn!.isNotEmpty) {
      return descriptionEn!;
    }
    return description;
  }

  static bool _defaultValid(Map<String, double> inputs) => true;

  @override
  String toString() => '$description ($latex)';
}
