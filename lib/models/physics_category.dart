enum PhysicsCategory {
  mechanics('Mekanik', 'Mechanics', '⚙️'),
  electricity('Elektrik & Manyetizma', 'Electricity & Magnetism', '⚡'),
  thermodynamics('Termodinamik', 'Thermodynamics', '🔥'),
  wavesOptics('Dalga & Optik', 'Waves & Optics', '🌊');

  final String labelTr;
  final String labelEn;
  final String icon;

  const PhysicsCategory(this.labelTr, this.labelEn, this.icon);

  String getLocalizedLabel(String langCode) =>
      langCode == 'en' ? labelEn : labelTr;

  String get label => labelTr;
}
