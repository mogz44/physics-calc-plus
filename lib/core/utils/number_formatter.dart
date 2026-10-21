/// Fiziksel değerleri akıllıca formatlayan yardımcı sınıf.
/// Çok küçük veya çok büyük değerler için bilimsel gösterim (örn: 1.25e-4),
/// standart değerler için temiz ondalık gösterim sunar.
class NumberFormatter {
  NumberFormatter._();

  static String format(double value, {int maxDecimals = 4}) {
    if (value.isNaN) return 'Tanımsız';
    if (value.isInfinite) return value.isNegative ? '-Sonsuz' : 'Sonsuz';
    if (value == 0.0) return '0';

    final absVal = value.abs();

    // Çok küçük veya çok büyük sayılar için bilimsel gösterim
    if (absVal >= 1e6 || absVal < 1e-4) {
      return value.toStringAsExponential(3);
    }

    // Gereksiz sıfırları temizle
    String str = value.toStringAsFixed(maxDecimals);
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0+$'), '');
      str = str.replaceAll(RegExp(r'\.$'), '');
    }
    return str;
  }
}
