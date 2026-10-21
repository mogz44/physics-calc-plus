import '../models/physics_unit.dart';

/// Tüm fiziksel büyüklüklerin SI taban birimleri ve alternatif birimleri.
class StandardUnits {
  StandardUnits._();

  // --- UZUNLUK / YOL (distance_d) ---
  static final distanceUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm', quantityId: 'distance_d', name: 'Metre', symbol: 'm', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'km', quantityId: 'distance_d', name: 'Kilometre', symbol: 'km', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'cm', quantityId: 'distance_d', name: 'Santimetre', symbol: 'cm', factorToSi: 0.01),
    PhysicsUnit.linear(id: 'mm', quantityId: 'distance_d', name: 'Milimetre', symbol: 'mm', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'mile', quantityId: 'distance_d', name: 'Mil', symbol: 'mi', factorToSi: 1609.344),
    PhysicsUnit.linear(id: 'foot', quantityId: 'distance_d', name: 'Fit', symbol: 'ft', factorToSi: 0.3048),
    PhysicsUnit.linear(id: 'inch', quantityId: 'distance_d', name: 'İnç', symbol: 'in', factorToSi: 0.0254),
  ];

  // --- ZAMAN (time_t) ---
  static final timeUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 's', quantityId: 'time_t', name: 'Saniye', symbol: 's', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'min', quantityId: 'time_t', name: 'Dakika', symbol: 'min', factorToSi: 60.0),
    PhysicsUnit.linear(id: 'h', quantityId: 'time_t', name: 'Saat', symbol: 'h', factorToSi: 3600.0),
    PhysicsUnit.linear(id: 'ms', quantityId: 'time_t', name: 'Milisaniye', symbol: 'ms', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'day', quantityId: 'time_t', name: 'Gün', symbol: 'd', factorToSi: 86400.0),
  ];

  // --- HIZ (velocity_v) ---
  static final velocityUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm_s', quantityId: 'velocity_v', name: 'Metre / Saniye', symbol: 'm/s', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'km_h', quantityId: 'velocity_v', name: 'Kilometre / Saat', symbol: 'km/h', factorToSi: 1.0 / 3.6),
    PhysicsUnit.linear(id: 'mph', quantityId: 'velocity_v', name: 'Mil / Saat', symbol: 'mph', factorToSi: 0.44704),
    PhysicsUnit.linear(id: 'knot', quantityId: 'velocity_v', name: 'Knot (Deniz Mili/s)', symbol: 'kn', factorToSi: 0.514444),
    PhysicsUnit.linear(id: 'ft_s', quantityId: 'velocity_v', name: 'Fit / Saniye', symbol: 'ft/s', factorToSi: 0.3048),
  ];

  // --- İVME & YERÇEKİMİ (accel_a & gravity_g) ---
  static final accelerationUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm_s2', quantityId: 'accel_a', name: 'Metre / Saniye²', symbol: 'm/s²', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'km_h2', quantityId: 'accel_a', name: 'Kilometre / Saat²', symbol: 'km/h²', factorToSi: 1.0 / 12960.0),
    PhysicsUnit.linear(id: 'g_force', quantityId: 'accel_a', name: 'Standart Yerçekimi (g)', symbol: 'g', factorToSi: 9.80665),
    PhysicsUnit.linear(id: 'ft_s2', quantityId: 'accel_a', name: 'Fit / Saniye²', symbol: 'ft/s²', factorToSi: 0.3048),
  ];

  static final gravityUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm_s2', quantityId: 'gravity_g', name: 'Metre / Saniye²', symbol: 'm/s²', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'ft_s2', quantityId: 'gravity_g', name: 'Fit / Saniye²', symbol: 'ft/s²', factorToSi: 0.3048),
  ];

  // --- KÜTLE (mass_m) ---
  static final massUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'kg', quantityId: 'mass_m', name: 'Kilogram', symbol: 'kg', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'g', quantityId: 'mass_m', name: 'Gram', symbol: 'g', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'mg', quantityId: 'mass_m', name: 'Miligram', symbol: 'mg', factorToSi: 0.000001),
    PhysicsUnit.linear(id: 'tonne', quantityId: 'mass_m', name: 'Ton (Metrik)', symbol: 't', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'lb', quantityId: 'mass_m', name: 'Pound (Libre)', symbol: 'lb', factorToSi: 0.45359237),
    PhysicsUnit.linear(id: 'oz', quantityId: 'mass_m', name: 'Ons', symbol: 'oz', factorToSi: 0.02834952),
  ];

  // --- KUVVET & AĞIRLIK (force_F & weight_W) ---
  static final forceUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'newton', quantityId: 'force_F', name: 'Newton', symbol: 'N', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'kN', quantityId: 'force_F', name: 'Kilonewton', symbol: 'kN', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'dyne', quantityId: 'force_F', name: 'Din', symbol: 'dyn', factorToSi: 1e-5),
    PhysicsUnit.linear(id: 'lbf', quantityId: 'force_F', name: 'Pound-Kuvvet', symbol: 'lbf', factorToSi: 4.448222),
    PhysicsUnit.linear(id: 'kgf', quantityId: 'force_F', name: 'Kilogram-Kuvvet', symbol: 'kgf', factorToSi: 9.80665),
  ];

  static final weightUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'newton', quantityId: 'weight_W', name: 'Newton', symbol: 'N', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'kN', quantityId: 'weight_W', name: 'Kilonewton', symbol: 'kN', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'kgf', quantityId: 'weight_W', name: 'Kilogram-Kuvvet', symbol: 'kgf', factorToSi: 9.80665),
    PhysicsUnit.linear(id: 'lbf', quantityId: 'weight_W', name: 'Pound-Kuvvet', symbol: 'lbf', factorToSi: 4.448222),
  ];

  // --- ENERJİ & İŞ (work_W, energy_Ek, energy_Ep) ---
  static List<PhysicsUnit> _createEnergyUnits(String qId) => [
    PhysicsUnit.linear(id: 'joule', quantityId: qId, name: 'Joule', symbol: 'J', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'kJ', quantityId: qId, name: 'Kilojoule', symbol: 'kJ', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'cal', quantityId: qId, name: 'Kalori', symbol: 'cal', factorToSi: 4.184),
    PhysicsUnit.linear(id: 'kcal', quantityId: qId, name: 'Kilokalori', symbol: 'kcal', factorToSi: 4184.0),
    PhysicsUnit.linear(id: 'Wh', quantityId: qId, name: 'Watt-saat', symbol: 'Wh', factorToSi: 3600.0),
    PhysicsUnit.linear(id: 'kWh', quantityId: qId, name: 'Kilowatt-saat', symbol: 'kWh', factorToSi: 3.6e6),
    PhysicsUnit.linear(id: 'eV', quantityId: qId, name: 'Elektronvolt', symbol: 'eV', factorToSi: 1.602176634e-19),
  ];

  static final workUnits = _createEnergyUnits('work_W');
  static final kineticEnergyUnits = _createEnergyUnits('energy_Ek');
  static final potentialEnergyUnits = _createEnergyUnits('energy_Ep');

  // --- GÜÇ (power_P) ---
  static final powerUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'watt', quantityId: 'power_P', name: 'Watt', symbol: 'W', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'kW', quantityId: 'power_P', name: 'Kilowatt', symbol: 'kW', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'MW', quantityId: 'power_P', name: 'Megawatt', symbol: 'MW', factorToSi: 1e6),
    PhysicsUnit.linear(id: 'hp_metric', quantityId: 'power_P', name: 'Beygir Gücü (Metrik BG)', symbol: 'BG', factorToSi: 735.49875),
    PhysicsUnit.linear(id: 'hp_imperial', quantityId: 'power_P', name: 'Horsepower (hp)', symbol: 'hp', factorToSi: 745.69987),
  ];

  // --- BASINÇ (pressure_P) ---
  static final pressureUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'pascal', quantityId: 'pressure_P', name: 'Pascal', symbol: 'Pa', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'kPa', quantityId: 'pressure_P', name: 'Kilopascal', symbol: 'kPa', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'bar', quantityId: 'pressure_P', name: 'Bar', symbol: 'bar', factorToSi: 100000.0),
    PhysicsUnit.linear(id: 'mbar', quantityId: 'pressure_P', name: 'Milibar', symbol: 'mbar', factorToSi: 100.0),
    PhysicsUnit.linear(id: 'atm', quantityId: 'pressure_P', name: 'Atmosfer', symbol: 'atm', factorToSi: 101325.0),
    PhysicsUnit.linear(id: 'psi', quantityId: 'pressure_P', name: 'PSI (Pound/sq in)', symbol: 'psi', factorToSi: 6894.757),
    PhysicsUnit.linear(id: 'mmHg', quantityId: 'pressure_P', name: 'Milimetre Cıva (Torr)', symbol: 'mmHg', factorToSi: 133.322),
  ];

  // --- MOMENTUM (momentum_p) ---
  static final momentumUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'kg_m_s', quantityId: 'momentum_p', name: 'kg·m/s', symbol: 'kg·m/s', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'N_s', quantityId: 'momentum_p', name: 'Newton·saniye', symbol: 'N·s', factorToSi: 1.0),
    PhysicsUnit.linear(id: 'g_cm_s', quantityId: 'momentum_p', name: 'g·cm/s', symbol: 'g·cm/s', factorToSi: 1e-5),
  ];

  // --- ALAN (area_A) ---
  static final areaUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm2', quantityId: 'area_A', name: 'Metrekare', symbol: 'm²', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'cm2', quantityId: 'area_A', name: 'Santimetrekare', symbol: 'cm²', factorToSi: 1e-4),
    PhysicsUnit.linear(id: 'mm2', quantityId: 'area_A', name: 'Milimetrekare', symbol: 'mm²', factorToSi: 1e-6),
    PhysicsUnit.linear(id: 'km2', quantityId: 'area_A', name: 'Kilometrekare', symbol: 'km²', factorToSi: 1e6),
    PhysicsUnit.linear(id: 'ha', quantityId: 'area_A', name: 'Hektar', symbol: 'ha', factorToSi: 10000.0),
  ];

  // --- HACİM (volume_V) ---
  static final volumeUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'm3', quantityId: 'volume_V', name: 'Metreküp', symbol: 'm³', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'L', quantityId: 'volume_V', name: 'Litre', symbol: 'L', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'mL', quantityId: 'volume_V', name: 'Mililitre', symbol: 'mL', factorToSi: 1e-6),
    PhysicsUnit.linear(id: 'cm3', quantityId: 'volume_V', name: 'Santimetreküp (cc)', symbol: 'cm³', factorToSi: 1e-6),
  ];

  // --- ÖZKÜTLE (density_rho) ---
  static final densityUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'kg_m3', quantityId: 'density_rho', name: 'kg/m³', symbol: 'kg/m³', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'g_cm3', quantityId: 'density_rho', name: 'g/cm³', symbol: 'g/cm³', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'g_mL', quantityId: 'density_rho', name: 'g/mL', symbol: 'g/mL', factorToSi: 1000.0),
  ];

  // --- ELEKTRİK AKIMI (current_I) ---
  static final currentUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'ampere', quantityId: 'current_I', name: 'Amper', symbol: 'A', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'mA', quantityId: 'current_I', name: 'Miliamper', symbol: 'mA', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'uA', quantityId: 'current_I', name: 'Mikroamper', symbol: 'µA', factorToSi: 1e-6),
    PhysicsUnit.linear(id: 'kA', quantityId: 'current_I', name: 'Kiloamper', symbol: 'kA', factorToSi: 1000.0),
  ];

  // --- GERİLİM (voltage_V) ---
  static final voltageUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'volt', quantityId: 'voltage_V', name: 'Volt', symbol: 'V', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'mV', quantityId: 'voltage_V', name: 'Milivolt', symbol: 'mV', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'kV', quantityId: 'voltage_V', name: 'Kilovolt', symbol: 'kV', factorToSi: 1000.0),
  ];

  // --- DİRENÇ (resistance_R) ---
  static final resistanceUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'ohm', quantityId: 'resistance_R', name: 'Ohm', symbol: 'Ω', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'k_ohm', quantityId: 'resistance_R', name: 'Kiloohm', symbol: 'kΩ', factorToSi: 1000.0),
    PhysicsUnit.linear(id: 'M_ohm', quantityId: 'resistance_R', name: 'Megaohm', symbol: 'MΩ', factorToSi: 1e6),
    PhysicsUnit.linear(id: 'm_ohm', quantityId: 'resistance_R', name: 'Miliohm', symbol: 'mΩ', factorToSi: 0.001),
  ];

  // --- ELEKTRİKSEL YÜK (charge_q) ---
  static final chargeUnits = <PhysicsUnit>[
    PhysicsUnit.linear(id: 'coulomb', quantityId: 'charge_q', name: 'Coulomb', symbol: 'C', factorToSi: 1.0, isSi: true),
    PhysicsUnit.linear(id: 'mC', quantityId: 'charge_q', name: 'Milicoulomb', symbol: 'mC', factorToSi: 0.001),
    PhysicsUnit.linear(id: 'uC', quantityId: 'charge_q', name: 'Mikrocoulomb', symbol: 'µC', factorToSi: 1e-6),
    PhysicsUnit.linear(id: 'mAh', quantityId: 'charge_q', name: 'Miliamper-saat', symbol: 'mAh', factorToSi: 3.6),
    PhysicsUnit.linear(id: 'Ah', quantityId: 'charge_q', name: 'Amper-saat', symbol: 'Ah', factorToSi: 3600.0),
  ];

  /// Büyüklük ID'sine göre birimler haritası
  static final Map<String, List<PhysicsUnit>> _unitsByQuantityId = {
    'distance_d': distanceUnits,
    'time_t': timeUnits,
    'velocity_v': velocityUnits,
    'accel_a': accelerationUnits,
    'gravity_g': gravityUnits,
    'mass_m': massUnits,
    'force_F': forceUnits,
    'weight_W': weightUnits,
    'work_W': workUnits,
    'energy_Ek': kineticEnergyUnits,
    'energy_Ep': potentialEnergyUnits,
    'power_P': powerUnits,
    'pressure_P': pressureUnits,
    'momentum_p': momentumUnits,
    'area_A': areaUnits,
    'volume_V': volumeUnits,
    'density_rho': densityUnits,
    'current_I': currentUnits,
    'voltage_V': voltageUnits,
    'resistance_R': resistanceUnits,
    'charge_q': chargeUnits,
  };

  /// Belirli bir büyüklüğe ait tüm birimleri getirir
  static List<PhysicsUnit> getUnitsForQuantity(String quantityId) {
    return _unitsByQuantityId[quantityId] ?? [];
  }

  /// Belirli bir büyüklüğün SI birimini getirir
  static PhysicsUnit? getSiUnit(String quantityId) {
    final units = getUnitsForQuantity(quantityId);
    if (units.isEmpty) return null;
    return units.firstWhere((u) => u.isSi, orElse: () => units.first);
  }

  /// Birim ID'sine ve büyüklük ID'sine göre birimi bulur
  static PhysicsUnit? findUnit(String quantityId, String unitId) {
    final units = getUnitsForQuantity(quantityId);
    return units.where((u) => u.id == unitId).firstOrNull;
  }
}
