import '../models/physics_category.dart';
import '../models/physics_quantity.dart';

/// Physics Calc+ kütüphanesindeki tüm fiziksel büyüklükler.
/// ID'ler çakışmaları (Örn: İş(W) vs Ağırlık(W), Güç(P) vs Basınç(P)) engellemek üzere benzersizdir.
class StandardQuantities {
  StandardQuantities._();

  // --- MEKANİK ---
  static const mass = PhysicsQuantity(
    id: 'mass_m',
    name: 'Kütle',
    symbol: 'm',
    icon: '🧱',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg',
  );

  static const distance = PhysicsQuantity(
    id: 'distance_d',
    name: 'Yol / Konum',
    symbol: 'd',
    icon: '📏',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm',
  );

  static const time = PhysicsQuantity(
    id: 'time_t',
    name: 'Zaman',
    symbol: 't',
    icon: '⏱️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 's',
  );

  static const velocity = PhysicsQuantity(
    id: 'velocity_v',
    name: 'Hız',
    symbol: 'v',
    icon: '🏎️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s',
  );

  static const acceleration = PhysicsQuantity(
    id: 'accel_a',
    name: 'İvme',
    symbol: 'a',
    icon: '🚀',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s2',
  );

  static const force = PhysicsQuantity(
    id: 'force_F',
    name: 'Kuvvet',
    symbol: 'F',
    icon: '💥',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'newton',
  );

  static const weight = PhysicsQuantity(
    id: 'weight_W',
    name: 'Ağırlık',
    symbol: 'W',
    icon: '⚖️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'newton',
  );

  static const work = PhysicsQuantity(
    id: 'work_W',
    name: 'İş',
    symbol: 'W',
    icon: '💼',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const kineticEnergy = PhysicsQuantity(
    id: 'energy_Ek',
    name: 'Kinetik Enerji',
    symbol: 'E_k',
    icon: '⚡',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const potentialEnergy = PhysicsQuantity(
    id: 'energy_Ep',
    name: 'Potansiyel Enerji',
    symbol: 'E_p',
    icon: '🏔️',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'joule',
  );

  static const power = PhysicsQuantity(
    id: 'power_P',
    name: 'Mekanik Güç',
    symbol: 'P',
    icon: '⚡',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'watt',
  );

  static const pressure = PhysicsQuantity(
    id: 'pressure_P',
    name: 'Basınç',
    symbol: 'P',
    icon: '🎈',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'pascal',
  );

  static const momentum = PhysicsQuantity(
    id: 'momentum_p',
    name: 'Momentum',
    symbol: 'p',
    icon: '🎳',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg_m_s',
  );

  static const area = PhysicsQuantity(
    id: 'area_A',
    name: 'Alan',
    symbol: 'A',
    icon: '📐',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm2',
  );

  static const volume = PhysicsQuantity(
    id: 'volume_V',
    name: 'Hacim',
    symbol: 'V',
    icon: '📦',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm3',
  );

  static const density = PhysicsQuantity(
    id: 'density_rho',
    name: 'Özkütle / Yoğunluk',
    symbol: 'ρ',
    icon: '🧊',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'kg_m3',
  );

  static const gravity = PhysicsQuantity(
    id: 'gravity_g',
    name: 'Yerçekimi İvmesi',
    symbol: 'g',
    icon: '🌍',
    category: PhysicsCategory.mechanics,
    defaultUnitId: 'm_s2',
  );

  // --- ELEKTRİK & MANYETİZMA ---
  static const current = PhysicsQuantity(
    id: 'current_I',
    name: 'Elektrik Akımı',
    symbol: 'I',
    icon: '🔌',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'ampere',
  );

  static const voltage = PhysicsQuantity(
    id: 'voltage_V',
    name: 'Gerilim (Voltaj)',
    symbol: 'V',
    icon: '🔋',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'volt',
  );

  static const resistance = PhysicsQuantity(
    id: 'resistance_R',
    name: 'Elektriksel Direnç',
    symbol: 'R',
    icon: '💡',
    category: PhysicsCategory.electricity,
    defaultUnitId: 'ohm',
  );

  static const charge = PhysicsQuantity(
    id: 'charge_q',
    name: 'Elektriksel Yük',
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
