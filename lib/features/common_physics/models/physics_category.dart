enum PhysicsCategory {
  mechanics('Mekanik', '⚙️'),
  electricity('Elektrik & Manyetizma', '⚡'),
  thermodynamics('Termodinamik', '🔥'),
  wavesOptics('Dalga & Optik', '🌊');

  final String label;
  final String icon;

  const PhysicsCategory(this.label, this.icon);
}
