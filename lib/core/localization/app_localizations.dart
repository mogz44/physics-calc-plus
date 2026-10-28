import 'package:flutter/material.dart';

/// Physics Calc+ TR/EN Yerelleştirme Sınıfı
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('tr'));
  }

  static const List<Locale> supportedLocales = [
    Locale('tr'),
    Locale('en'),
  ];

  String get languageCode => locale.languageCode;
  bool get isTurkish => languageCode == 'tr';

  // --- NAVİGASYON ---
  String get navCalculator => isTurkish ? 'Hesaplayıcı' : 'Calculator';
  String get navConverter => isTurkish ? 'Dönüştürücü' : 'Converter';
  String get navSettings => isTurkish ? 'Ayarlar' : 'Settings';

  // --- GENEL & AKSİYONLAR ---
  String get appTitle => 'Physics Calc+';
  String get addValue => isTurkish ? 'Değer Ekle' : 'Add Value';
  String get viewReport => isTurkish ? 'Sonuç Raporunu Gör' : 'View Solution Report';
  String viewReportWithCount(int count) => isTurkish
      ? 'Sonuç Raporunu Gör ($count Değer)'
      : 'View Solution Report ($count Values)';
  String get clearInputs => isTurkish ? 'Girdileri Temizle' : 'Clear Inputs';
  String get deleteRow => isTurkish ? 'Satırı Sil' : 'Delete Row';
  String get selectQuantity => isTurkish ? 'Fiziksel Büyüklük Seç' : 'Select Physical Quantity';
  String get searchQuantityHint => isTurkish
      ? 'Büyüklük veya sembol ara (örn: Güç, W, v)...'
      : 'Search quantity or symbol (e.g. Power, W, v)...';
  String get all => isTurkish ? 'Tümü' : 'All';
  String get noResults => isTurkish ? 'Sonuç bulunamadı' : 'No results found';
  String get knownValuesHeader => isTurkish ? 'BİLİNEN DEĞERLER' : 'KNOWN VALUES';
  String get verticalCardsSubtitle => isTurkish ? 'Dikey Giriş Kartları' : 'Vertical Input Cards';
  String derivedCountBanner(int count) => isTurkish
      ? '$count yeni büyüklük zincirleme çözüldü!'
      : '$count new quantities derived in chain!';
  String get inspect => isTurkish ? 'İncele' : 'Inspect';
  String get enterValueHint => isTurkish ? 'Değer girin (örn: 10.5)' : 'Enter value (e.g. 10.5)';
  String get unit => isTurkish ? 'Birim' : 'Unit';
  String get invalidInputWarning => isTurkish
      ? 'Lütfen geçerli veri büyüklüğü ve sayısal değer girin.'
      : 'Please enter a valid quantity and numerical value.';

  // --- RAPOR MODAL / EKRANI ---
  String get solutionReport => isTurkish ? 'Çözüm Raporu' : 'Solution Report';
  String get chainedInferenceEngine => isTurkish ? 'Zincirleme Çıkarım Motoru' : 'Chained Inference Engine';
  String derivedQuantitiesTitle(int count) => isTurkish
      ? 'Türetilen Yeni Büyüklükler ($count)'
      : 'Derived Quantities ($count)';
  String get noDerivedQuantitiesWarning => isTurkish
      ? 'Girilen parametrelerle yeni bir fiziksel büyüklük türetilemedi. Daha fazla parametre eklemeyi deneyin.'
      : 'No new quantities could be derived with the provided parameters. Try adding more parameters.';
  String get solutionTreeTitle => isTurkish ? 'Adım Adım Çözüm Ağacı' : 'Step-by-Step Solution Tree';
  String stepIndex(int index) => isTurkish ? '$index. Adım' : 'Step $index';
  String stepsCount(int count) => isTurkish ? '$count Adım' : '$count Steps';
  String get usedParameters => isTurkish ? 'Kullanılan Parametreler:' : 'Used Parameters:';
  String get initialInputsNormalized => isTurkish
      ? 'Başlangıç Girdileri (SI Normalize):'
      : 'Initial Inputs (SI Normalized):';

  // --- DÖNÜŞTÜRÜCÜ (CONVERTER) ---
  String get converterTitle => 'Physics Converter';
  String get quantityToConvert => isTurkish ? 'Dönüştürülecek Büyüklük' : 'Quantity to Convert';
  String get valueToConvert => isTurkish ? 'Dönüştürülecek Değer' : 'Value to Convert';
  String get fromUnit => isTurkish ? 'Kaynak Birim' : 'From Unit';
  String get toUnit => isTurkish ? 'Hedef Birim' : 'To Unit';
  String get swapUnits => isTurkish ? 'Birimleri Değiştir' : 'Swap Units';
  String allEquivalentUnits(String name) => isTurkish
      ? 'Tüm Eşdeğer Birimler ($name)'
      : 'All Equivalent Units ($name)';
  String get siBaseUnit => isTurkish ? 'SI Taban Birimi' : 'SI Base Unit';

  // --- AYARLAR (SETTINGS) ---
  String get settingsTitle => isTurkish ? 'Ayarlar' : 'Settings';
  String get calcEngineSection => isTurkish ? 'HESAPLAMA MOTORU' : 'CALCULATION ENGINE';
  String get decimalPrecision => isTurkish ? 'Ondalık Hassasiyeti' : 'Decimal Precision';
  String get decimalPrecisionSubtitle => isTurkish
      ? 'Varsayılan 4 basamak (Akıllı formatlama)'
      : 'Default 4 digits (Smart formatting)';
  String get digitsCount => isTurkish ? '4 Hane' : '4 Digits';
  String get autoSiNormalization => isTurkish ? 'Otomatik SI Normalizasyonu' : 'Automatic SI Normalization';
  String get autoSiSubtitle => isTurkish
      ? 'Farklı birimler hesaplama öncesi SI tabanına çevrilir'
      : 'Units converted to SI base before calculation';
  String get zeroDivisionGuard => isTurkish ? 'Sıfıra Bölünme Koruması' : 'Division by Zero Guard';
  String get zeroDivisionSubtitle => isTurkish
      ? 'Matematiksel kısıtlar (isValid) denetlenir'
      : 'Mathematical constraints (isValid) validated';

  String get appearanceSection => isTurkish ? 'GÖRÜNÜM' : 'APPEARANCE';
  String get themeSetting => isTurkish ? 'Tema' : 'Theme';
  String get themeSystem => isTurkish ? 'Sistem Varsayılanı' : 'System Default';
  String get themeLight => isTurkish ? 'Açık Tema' : 'Light Theme';
  String get themeDark => isTurkish ? 'Koyu Tema' : 'Dark Theme';

  String get languageSetting => isTurkish ? 'Dil / Language' : 'Language';
  String get turkish => isTurkish ? 'Türkçe (TR)' : 'Turkish (TR)';
  String get english => isTurkish ? 'İngilizce (EN)' : 'English (EN)';

  String get cardArchitecture => isTurkish ? 'Kart Mimarisi' : 'Card Architecture';
  String get cardArchitectureSubtitle => isTurkish
      ? 'Dikey Esnek Kart (Stacked) Tasarımı'
      : 'Vertical Stacked Card Design';
  String get active => isTurkish ? 'Aktif' : 'Active';

  String get aboutSection => isTurkish ? 'HAKKINDA & LİSANS' : 'ABOUT & LICENSE';
  String get license => isTurkish ? 'Lisans' : 'License';
  String get licenseGpl => 'GNU General Public License v3.0 (GPL-3.0)';
  String get privacyFdroid => isTurkish ? 'F-Droid ve Gizlilik' : 'F-Droid & Privacy';
  String get privacySubtitle => isTurkish
      ? '%100 Çevrimdışı, Sıfır Takipçi, Tamamen Açık Kaynak'
      : '100% Offline, Zero Trackers, Fully Open Source';

  // --- ONBOARDING ---
  String get onboardingSkip => isTurkish ? 'Geç' : 'Skip';
  String get onboardingNext => isTurkish ? 'Devam' : 'Next';
  String get onboardingStart => isTurkish ? 'Başla' : 'Get Started';

  String get onboardingPage1Title => isTurkish ? 'Fizik Hesaplamalarını\nÇöz' : 'Solve Physics\nCalculations';
  String get onboardingPage1Subtitle => isTurkish
      ? 'Zincirleme Çıkarım Motoru ile girilen verilerden otomatik olarak yeni fiziksel büyüklükler türet.'
      : 'Automatically derive new physical quantities from your inputs using the Chained Inference Engine.';
  String get onboardingPage1Feature1 => isTurkish ? 'Dikey esnek girdi kartları' : 'Vertical stacked input cards';
  String get onboardingPage1Feature2 => isTurkish ? 'Otomatik formül zinciri' : 'Automatic formula chaining';
  String get onboardingPage1Feature3 => isTurkish ? 'Adım adım çözüm raporu' : 'Step-by-step solution report';

  String get onboardingPage2Title => isTurkish ? 'Tercihlerini Seç' : 'Choose Your Preferences';
  String get onboardingPage2Subtitle => isTurkish
      ? 'Dil ve tema seçimini şimdi yap. Daha sonra Ayarlar\'dan değiştirebilirsin.'
      : 'Set your language and theme now. You can change them anytime in Settings.';
  String get onboardingPage2ThemeLabel => isTurkish ? 'Tema' : 'Theme';
  String get onboardingPage2LangLabel => isTurkish ? 'Dil / Language' : 'Language';
  String get systemDefault => isTurkish ? 'Sistem' : 'System';

  String get onboardingPage3Title => isTurkish ? 'Nasıl Kullanılır?' : 'How to Use?';
  String get onboardingPage3Subtitle => isTurkish
      ? 'Birkaç adımda fizik problemlerini çözmeye başla!'
      : 'Start solving physics problems in just a few steps!';
  String get onboardingPage3Step1 => isTurkish ? '1. "Değer Ekle" ile fiziksel büyüklükler ekle' : '1. Tap "Add Value" to add physical quantities';
  String get onboardingPage3Step2 => isTurkish ? '2. Her karta büyüklük, değer ve birim gir' : '2. Enter quantity, value and unit for each card';
  String get onboardingPage3Step3 => isTurkish ? '3. Motor otomatik olarak yeni değerler türetir' : '3. The engine automatically derives new values';
  String get onboardingPage3Step4 => isTurkish ? '4. "Çözüm Raporunu Gör" ile detaylı analiz' : '4. Tap "View Report" for detailed analysis';

  // --- AYARLAR EKSTRA ---
  String get viewOnboardingAgain => isTurkish ? 'Kullanım Rehberini Tekrar Gör' : 'View Onboarding Again';
  String get viewOnboardingSubtitle => isTurkish ? 'Uygulama rehberini baştan aç' : 'Reopen the app guide from the beginning';
  String get developedBy => 'Developed with ♥ by Mogz';
  String get appVersion => 'v1.1.0';
  String get githubLink => 'GitHub';
  String get izzyLink => 'IzzyOnDroid';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['tr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
