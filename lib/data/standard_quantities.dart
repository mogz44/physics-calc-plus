import '../models/physics_category.dart';
import '../models/physics_quantity.dart';

/// Physics Calc+ kütüphanesindeki tüm fiziksel büyüklükler (TR / EN destekli).
class StandardQuantities {
  StandardQuantities._();

  // --- MEKANİK ---
  static const mass = PhysicsQuantity(
    id: 'mass_m',
    name: 'Kütle',
    nameEn: 'Mass',
    symbol: 'm',
    icon: '🧱',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg',
  );

  static const distance = PhysicsQuantity(
    id: 'distance_d',
    name: 'Yol / Konum',
    nameEn: 'Distance / Displacement',
    symbol: 'd',
    icon: '📏',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm',
  );

  static const time = PhysicsQuantity(
    id: 'time_t',
    name: 'Zaman',
    nameEn: 'Time',
    symbol: 't',
    icon: '⏱️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 's',
  );

  static const velocity = PhysicsQuantity(
    id: 'velocity_v',
    name: 'Hız',
    nameEn: 'Velocity',
    symbol: 'v',
    icon: '🏎️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s',
  );

  static const acceleration = PhysicsQuantity(
    id: 'accel_a',
    name: 'İvme',
    nameEn: 'Acceleration',
    symbol: 'a',
    icon: '🚀',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s2',
  );

  static const force = PhysicsQuantity(
    id: 'force_F',
    name: 'Kuvvet',
    nameEn: 'Force',
    symbol: 'F',
    icon: '💥',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'newton',
  );

  static const weight = PhysicsQuantity(
    id: 'weight_W',
    name: 'Ağırlık',
    nameEn: 'Weight',
    symbol: 'W',
    icon: '⚖️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'newton',
  );

  static const work = PhysicsQuantity(
    id: 'work_W',
    name: 'İş',
    nameEn: 'Work',
    symbol: 'W',
    icon: '💼',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const kineticEnergy = PhysicsQuantity(
    id: 'energy_Ek',
    name: 'Kinetik Enerji',
    nameEn: 'Kinetic Energy',
    symbol: 'E_k',
    icon: '⚡',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const potentialEnergy = PhysicsQuantity(
    id: 'energy_Ep',
    name: 'Potansiyel Enerji',
    nameEn: 'Potential Energy',
    symbol: 'E_p',
    icon: '🏔️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const power = PhysicsQuantity(
    id: 'power_P',
    name: 'Mekanik Güç',
    nameEn: 'Mechanical Power',
    symbol: 'P',
    icon: '⚡',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'watt',
  );

  static const pressure = PhysicsQuantity(
    id: 'pressure_P',
    name: 'Basınç',
    nameEn: 'Pressure',
    symbol: 'P',
    icon: '🎈',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'pascal',
  );

  static const momentum = PhysicsQuantity(
    id: 'momentum_p',
    name: 'Momentum',
    nameEn: 'Linear Momentum',
    symbol: 'p',
    icon: '🎳',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg_m_s',
  );

  static const impulse = PhysicsQuantity(
    id: 'impulse_I',
    name: 'İtiş (İmpuls)',
    nameEn: 'Impulse',
    symbol: 'I',
    icon: '💥',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'N_s_impulse',
  );

  static const area = PhysicsQuantity(
    id: 'area_A',
    name: 'Alan',
    nameEn: 'Area',
    symbol: 'A',
    icon: '📐',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm2',
  );

  static const volume = PhysicsQuantity(
    id: 'volume_V',
    name: 'Hacim',
    nameEn: 'Volume',
    symbol: 'V',
    icon: '📦',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm3',
  );

  static const density = PhysicsQuantity(
    id: 'density_rho',
    name: 'Özkütle / Yoğunluk',
    nameEn: 'Density',
    symbol: 'ρ',
    icon: '🧊',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg_m3',
  );

  static const gravity = PhysicsQuantity(
    id: 'gravity_g',
    name: 'Yerçekimi İvmesi',
    nameEn: 'Gravitational Acceleration',
    symbol: 'g',
    icon: '🌍',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s2',
  );

  // --- ELEKTRİK & MANYETİZMA ---
  static const current = PhysicsQuantity(
    id: 'current_I',
    name: 'Elektrik Akımı',
    nameEn: 'Electric Current',
    symbol: 'I',
    icon: '🔌',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'ampere',
  );

  static const voltage = PhysicsQuantity(
    id: 'voltage_V',
    name: 'Gerilim (Voltaj)',
    nameEn: 'Voltage',
    symbol: 'V',
    icon: '🔋',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'volt',
  );

  static const resistance = PhysicsQuantity(
    id: 'resistance_R',
    name: 'Elektriksel Direnç',
    nameEn: 'Resistance',
    symbol: 'R',
    icon: '💡',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'ohm',
  );

  static const charge = PhysicsQuantity(
    id: 'charge_q',
    name: 'Elektriksel Yük',
    nameEn: 'Electric Charge',
    symbol: 'q',
    icon: '⚡',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'coulomb',
  );

  /// Tüm kayıtlı büyüklüklerin listesi
  static const List<PhysicsQuantity> all = [
    // Mekanik
    distance,
    time,
    velocity,
    acceleration,
    mass,
    force,
    weight,
    work,
    kineticEnergy,
    potentialEnergy,
    power,
    pressure,
    momentum,
    impulse,
    area,
    volume,
    density,
    gravity,
    // Elektrik
    current,
    voltage,
    resistance,
    charge,
  ];

  static final Map<String, PhysicsQuantity> _byId = {
    for (final q in all) q.id: q,
  };

  static PhysicsQuantity? getById(String id) => _byId[id];
}
