import 'dart:math' as math;
import '../models/formula.dart';

/// Physics Calc+ kütüphanesindeki tüm formüller ve açık türevleri.
/// Her formül tek bir hedef büyüklüğü bulur ve sıfıra bölünme kontrollerini içerir.
class StandardFormulas {
  StandardFormulas._();

  static final List<Formula> all = [
    // ==========================================
    // 1. SABİT HIZLI HAREKET (d = v * t)
    // ==========================================
    Formula(
      id: 'kinematics_dist_from_vt',
      groupName: 'Sabit Hızlı Hareket',
      description: 'Mesafe Hesabı',
      latex: 'd = v \\cdot t',
      targetQuantityId: 'distance_d',
      requiredQuantityIds: ['velocity_v', 'time_t'],
      calculate: (v) => v['velocity_v']! * v['time_t']!,
    ),
    Formula(
      id: 'kinematics_vel_from_dt',
      groupName: 'Sabit Hızlı Hareket',
      description: 'Hız Hesabı',
      latex: 'v = d / t',
      targetQuantityId: 'velocity_v',
      requiredQuantityIds: ['distance_d', 'time_t'],
      isValid: (v) => v['time_t']! != 0,
      calculate: (v) => v['distance_d']! / v['time_t']!,
    ),
    Formula(
      id: 'kinematics_time_from_dv',
      groupName: 'Sabit Hızlı Hareket',
      description: 'Zaman Hesabı',
      latex: 't = d / v',
      targetQuantityId: 'time_t',
      requiredQuantityIds: ['distance_d', 'velocity_v'],
      isValid: (v) => v['velocity_v']! != 0,
      calculate: (v) => v['distance_d']! / v['velocity_v']!,
    ),

    // ==========================================
    // 2. SABİT İVMELİ HIZ DEĞİŞİMİ (v = a * t)
    // ==========================================
    Formula(
      id: 'kinematics_vel_from_at',
      groupName: 'Sabit İvmeli Hareket',
      description: 'Hız Hesabı',
      latex: 'v = a \\cdot t',
      targetQuantityId: 'velocity_v',
      requiredQuantityIds: ['accel_a', 'time_t'],
      calculate: (v) => v['accel_a']! * v['time_t']!,
    ),
    Formula(
      id: 'kinematics_accel_from_vt',
      groupName: 'Sabit İvmeli Hareket',
      description: 'İvme Hesabı',
      latex: 'a = v / t',
      targetQuantityId: 'accel_a',
      requiredQuantityIds: ['velocity_v', 'time_t'],
      isValid: (v) => v['time_t']! != 0,
      calculate: (v) => v['velocity_v']! / v['time_t']!,
    ),
    Formula(
      id: 'kinematics_time_from_va',
      groupName: 'Sabit İvmeli Hareket',
      description: 'Zaman Hesabı',
      latex: 't = v / a',
      targetQuantityId: 'time_t',
      requiredQuantityIds: ['velocity_v', 'accel_a'],
      isValid: (v) => v['accel_a']! != 0,
      calculate: (v) => v['velocity_v']! / v['accel_a']!,
    ),

    // ==========================================
    // 3. NEWTON 2. YASASI (F = m * a)
    // ==========================================
    Formula(
      id: 'newton_2nd_force',
      groupName: 'Newton 2. Yasası',
      description: 'Kuvvet Hesabı',
      latex: 'F = m \\cdot a',
      targetQuantityId: 'force_F',
      requiredQuantityIds: ['mass_m', 'accel_a'],
      calculate: (v) => v['mass_m']! * v['accel_a']!,
    ),
    Formula(
      id: 'newton_2nd_mass',
      groupName: 'Newton 2. Yasası',
      description: 'Kütle Hesabı',
      latex: 'm = F / a',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['force_F', 'accel_a'],
      isValid: (v) => v['accel_a']! != 0,
      calculate: (v) => v['force_F']! / v['accel_a']!,
    ),
    Formula(
      id: 'newton_2nd_accel',
      groupName: 'Newton 2. Yasası',
      description: 'İvme Hesabı',
      latex: 'a = F / m',
      targetQuantityId: 'accel_a',
      requiredQuantityIds: ['force_F', 'mass_m'],
      isValid: (v) => v['mass_m']! != 0,
      calculate: (v) => v['force_F']! / v['mass_m']!,
    ),

    // ==========================================
    // 4. AĞIRLIK (W = m * g)
    // ==========================================
    Formula(
      id: 'gravity_weight',
      groupName: 'Ağırlık Hesabı',
      description: 'Ağırlık Hesabı',
      latex: 'W = m \\cdot g',
      targetQuantityId: 'weight_W',
      requiredQuantityIds: ['mass_m', 'gravity_g'],
      calculate: (v) => v['mass_m']! * v['gravity_g']!,
    ),
    Formula(
      id: 'gravity_mass_from_weight',
      groupName: 'Ağırlık Hesabı',
      description: 'Kütle Hesabı',
      latex: 'm = W / g',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['weight_W', 'gravity_g'],
      isValid: (v) => v['gravity_g']! != 0,
      calculate: (v) => v['weight_W']! / v['gravity_g']!,
    ),
    Formula(
      id: 'gravity_g_from_weight',
      groupName: 'Ağırlık Hesabı',
      description: 'Yerçekimi İvmesi Hesabı',
      latex: 'g = W / m',
      targetQuantityId: 'gravity_g',
      requiredQuantityIds: ['weight_W', 'mass_m'],
      isValid: (v) => v['mass_m']! != 0,
      calculate: (v) => v['weight_W']! / v['mass_m']!,
    ),

    // ==========================================
    // 5. MEKANİK İŞ (W = F * d)
    // ==========================================
    Formula(
      id: 'work_from_force_dist',
      groupName: 'Mekanik İş',
      description: 'İş Hesabı',
      latex: 'W = F \\cdot d',
      targetQuantityId: 'work_W',
      requiredQuantityIds: ['force_F', 'distance_d'],
      calculate: (v) => v['force_F']! * v['distance_d']!,
    ),
    Formula(
      id: 'force_from_work_dist',
      groupName: 'Mekanik İş',
      description: 'Kuvvet Hesabı',
      latex: 'F = W / d',
      targetQuantityId: 'force_F',
      requiredQuantityIds: ['work_W', 'distance_d'],
      isValid: (v) => v['distance_d']! != 0,
      calculate: (v) => v['work_W']! / v['distance_d']!,
    ),
    Formula(
      id: 'dist_from_work_force',
      groupName: 'Mekanik İş',
      description: 'Yol Hesabı',
      latex: 'd = W / F',
      targetQuantityId: 'distance_d',
      requiredQuantityIds: ['work_W', 'force_F'],
      isValid: (v) => v['force_F']! != 0,
      calculate: (v) => v['work_W']! / v['force_F']!,
    ),

    // ==========================================
    // 6. KİNETİK ENERJİ (Ek = 0.5 * m * v^2)
    // ==========================================
    Formula(
      id: 'kinetic_energy_Ek',
      groupName: 'Kinetik Enerji',
      description: 'Kinetik Enerji Hesabı',
      latex: 'E_k = \\frac{1}{2} m v^2',
      targetQuantityId: 'energy_Ek',
      requiredQuantityIds: ['mass_m', 'velocity_v'],
      calculate: (v) => 0.5 * v['mass_m']! * math.pow(v['velocity_v']!, 2),
    ),
    Formula(
      id: 'kinetic_energy_velocity',
      groupName: 'Kinetik Enerji',
      description: 'Hız Hesabı',
      latex: 'v = \\sqrt{\\frac{2 E_k}{m}}',
      targetQuantityId: 'velocity_v',
      requiredQuantityIds: ['energy_Ek', 'mass_m'],
      isValid: (v) => v['mass_m']! > 0 && (2 * v['energy_Ek']! / v['mass_m']!) >= 0,
      calculate: (v) => math.sqrt((2 * v['energy_Ek']!) / v['mass_m']!),
    ),
    Formula(
      id: 'kinetic_energy_mass',
      groupName: 'Kinetik Enerji',
      description: 'Kütle Hesabı',
      latex: 'm = \\frac{2 E_k}{v^2}',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['energy_Ek', 'velocity_v'],
      isValid: (v) => v['velocity_v']! != 0,
      calculate: (v) => (2 * v['energy_Ek']!) / math.pow(v['velocity_v']!, 2),
    ),

    // ==========================================
    // 7. POTANSİYEL ENERJİ (Ep = m * g * d)
    // ==========================================
    Formula(
      id: 'potential_energy_Ep',
      groupName: 'Potansiyel Enerji',
      description: 'Potansiyel Enerji Hesabı',
      latex: 'E_p = m \\cdot g \\cdot d',
      targetQuantityId: 'energy_Ep',
      requiredQuantityIds: ['mass_m', 'gravity_g', 'distance_d'],
      calculate: (v) => v['mass_m']! * v['gravity_g']! * v['distance_d']!,
    ),
    Formula(
      id: 'potential_energy_dist',
      groupName: 'Potansiyel Enerji',
      description: 'Yükseklik Hesabı',
      latex: 'd = E_p / (m \\cdot g)',
      targetQuantityId: 'distance_d',
      requiredQuantityIds: ['energy_Ep', 'mass_m', 'gravity_g'],
      isValid: (v) => (v['mass_m']! * v['gravity_g']!) != 0,
      calculate: (v) => v['energy_Ep']! / (v['mass_m']! * v['gravity_g']!),
    ),
    Formula(
      id: 'potential_energy_mass',
      groupName: 'Potansiyel Enerji',
      description: 'Kütle Hesabı',
      latex: 'm = E_p / (g \\cdot d)',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['energy_Ep', 'gravity_g', 'distance_d'],
      isValid: (v) => (v['gravity_g']! * v['distance_d']!) != 0,
      calculate: (v) => v['energy_Ep']! / (v['gravity_g']! * v['distance_d']!),
    ),

    // ==========================================
    // 8. MEKANİK GÜÇ (P = W / t)
    // ==========================================
    Formula(
      id: 'power_from_work_time',
      groupName: 'Güç',
      description: 'Güç Hesabı',
      latex: 'P = W / t',
      targetQuantityId: 'power_P',
      requiredQuantityIds: ['work_W', 'time_t'],
      isValid: (v) => v['time_t']! != 0,
      calculate: (v) => v['work_W']! / v['time_t']!,
    ),
    Formula(
      id: 'work_from_power_time',
      groupName: 'Güç',
      description: 'İş Hesabı',
      latex: 'W = P \\cdot t',
      targetQuantityId: 'work_W',
      requiredQuantityIds: ['power_P', 'time_t'],
      calculate: (v) => v['power_P']! * v['time_t']!,
    ),
    Formula(
      id: 'time_from_work_power',
      groupName: 'Güç',
      description: 'Zaman Hesabı',
      latex: 't = W / P',
      targetQuantityId: 'time_t',
      requiredQuantityIds: ['work_W', 'power_P'],
      isValid: (v) => v['power_P']! != 0,
      calculate: (v) => v['work_W']! / v['power_P']!,
    ),

    // ==========================================
    // 9. BASINÇ (P = F / A)
    // ==========================================
    Formula(
      id: 'pressure_from_force_area',
      groupName: 'Basınç',
      description: 'Basınç Hesabı',
      latex: 'P = F / A',
      targetQuantityId: 'pressure_P',
      requiredQuantityIds: ['force_F', 'area_A'],
      isValid: (v) => v['area_A']! != 0,
      calculate: (v) => v['force_F']! / v['area_A']!,
    ),
    Formula(
      id: 'force_from_pressure_area',
      groupName: 'Basınç',
      description: 'Kuvvet Hesabı',
      latex: 'F = P \\cdot A',
      targetQuantityId: 'force_F',
      requiredQuantityIds: ['pressure_P', 'area_A'],
      calculate: (v) => v['pressure_P']! * v['area_A']!,
    ),
    Formula(
      id: 'area_from_pressure_force',
      groupName: 'Basınç',
      description: 'Alan Hesabı',
      latex: 'A = F / P',
      targetQuantityId: 'area_A',
      requiredQuantityIds: ['force_F', 'pressure_P'],
      isValid: (v) => v['pressure_P']! != 0,
      calculate: (v) => v['force_F']! / v['pressure_P']!,
    ),

    // ==========================================
    // 10. MOMENTUM (p = m * v)
    // ==========================================
    Formula(
      id: 'momentum_from_mass_vel',
      groupName: 'Momentum',
      description: 'Momentum Hesabı',
      latex: 'p = m \\cdot v',
      targetQuantityId: 'momentum_p',
      requiredQuantityIds: ['mass_m', 'velocity_v'],
      calculate: (v) => v['mass_m']! * v['velocity_v']!,
    ),
    Formula(
      id: 'vel_from_momentum_mass',
      groupName: 'Momentum',
      description: 'Hız Hesabı',
      latex: 'v = p / m',
      targetQuantityId: 'velocity_v',
      requiredQuantityIds: ['momentum_p', 'mass_m'],
      isValid: (v) => v['mass_m']! != 0,
      calculate: (v) => v['momentum_p']! / v['mass_m']!,
    ),
    Formula(
      id: 'mass_from_momentum_vel',
      groupName: 'Momentum',
      description: 'Kütle Hesabı',
      latex: 'm = p / v',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['momentum_p', 'velocity_v'],
      isValid: (v) => v['velocity_v']! != 0,
      calculate: (v) => v['momentum_p']! / v['velocity_v']!,
    ),

    // ==========================================
    // 10.1 İTİŞ / İMPULS (I = F * dt)
    // ==========================================
    Formula(
      id: 'impulse_from_force_time',
      groupName: 'İtiş (İmpuls)',
      groupNameEn: 'Impulse',
      description: 'İtiş Hesabı',
      descriptionEn: 'Impulse Calculation',
      latex: 'I = F \\cdot \\Delta t',
      targetQuantityId: 'impulse_I',
      requiredQuantityIds: ['force_F', 'time_t'],
      calculate: (v) => v['force_F']! * v['time_t']!,
    ),
    Formula(
      id: 'force_from_impulse_time',
      groupName: 'İtiş (İmpuls)',
      groupNameEn: 'Impulse',
      description: 'Kuvvet Hesabı',
      descriptionEn: 'Force Calculation',
      latex: 'F = I / \\Delta t',
      targetQuantityId: 'force_F',
      requiredQuantityIds: ['impulse_I', 'time_t'],
      isValid: (v) => v['time_t']! != 0,
      calculate: (v) => v['impulse_I']! / v['time_t']!,
    ),
    Formula(
      id: 'time_from_impulse_force',
      groupName: 'İtiş (İmpuls)',
      groupNameEn: 'Impulse',
      description: 'Etki Süresi Hesabı',
      descriptionEn: 'Interaction Time Calculation',
      latex: '\\Delta t = I / F',
      targetQuantityId: 'time_t',
      requiredQuantityIds: ['impulse_I', 'force_F'],
      isValid: (v) => v['force_F']! != 0,
      calculate: (v) => v['impulse_I']! / v['force_F']!,
    ),

    // ==========================================
    // 11. ÖZKÜTLE (ρ = m / V)
    // ==========================================
    Formula(
      id: 'density_from_mass_vol',
      groupName: 'Özkütle',
      description: 'Özkütle Hesabı',
      latex: '\\rho = m / V',
      targetQuantityId: 'density_rho',
      requiredQuantityIds: ['mass_m', 'volume_V'],
      isValid: (v) => v['volume_V']! != 0,
      calculate: (v) => v['mass_m']! / v['volume_V']!,
    ),
    Formula(
      id: 'mass_from_density_vol',
      groupName: 'Özkütle',
      description: 'Kütle Hesabı',
      latex: 'm = \\rho \\cdot V',
      targetQuantityId: 'mass_m',
      requiredQuantityIds: ['density_rho', 'volume_V'],
      calculate: (v) => v['density_rho']! * v['volume_V']!,
    ),
    Formula(
      id: 'vol_from_density_mass',
      groupName: 'Özkütle',
      description: 'Hacim Hesabı',
      latex: 'V = m / \\rho',
      targetQuantityId: 'volume_V',
      requiredQuantityIds: ['mass_m', 'density_rho'],
      isValid: (v) => v['density_rho']! != 0,
      calculate: (v) => v['mass_m']! / v['density_rho']!,
    ),

    // ==========================================
    // 12. OHM YASASI (V = I * R)
    // ==========================================
    Formula(
      id: 'ohm_voltage',
      groupName: 'Ohm Yasası',
      description: 'Gerilim Hesabı',
      latex: 'V = I \\cdot R',
      targetQuantityId: 'voltage_V',
      requiredQuantityIds: ['current_I', 'resistance_R'],
      calculate: (v) => v['current_I']! * v['resistance_R']!,
    ),
    Formula(
      id: 'ohm_current',
      groupName: 'Ohm Yasası',
      description: 'Akım Hesabı',
      latex: 'I = V / R',
      targetQuantityId: 'current_I',
      requiredQuantityIds: ['voltage_V', 'resistance_R'],
      isValid: (v) => v['resistance_R']! != 0,
      calculate: (v) => v['voltage_V']! / v['resistance_R']!,
    ),
    Formula(
      id: 'ohm_resistance',
      groupName: 'Ohm Yasası',
      description: 'Direnç Hesabı',
      latex: 'R = V / I',
      targetQuantityId: 'resistance_R',
      requiredQuantityIds: ['voltage_V', 'current_I'],
      isValid: (v) => v['current_I']! != 0,
      calculate: (v) => v['voltage_V']! / v['current_I']!,
    ),

    // ==========================================
    // 13. ELEKTRİKSEL GÜÇ (P = V * I)
    // ==========================================
    Formula(
      id: 'electric_power_from_VI',
      groupName: 'Elektriksel Güç',
      description: 'Güç Hesabı',
      latex: 'P = V \\cdot I',
      targetQuantityId: 'power_P',
      requiredQuantityIds: ['voltage_V', 'current_I'],
      calculate: (v) => v['voltage_V']! * v['current_I']!,
    ),
    Formula(
      id: 'voltage_from_PI',
      groupName: 'Elektriksel Güç',
      description: 'Gerilim Hesabı',
      latex: 'V = P / I',
      targetQuantityId: 'voltage_V',
      requiredQuantityIds: ['power_P', 'current_I'],
      isValid: (v) => v['current_I']! != 0,
      calculate: (v) => v['power_P']! / v['current_I']!,
    ),
    Formula(
      id: 'current_from_PV',
      groupName: 'Elektriksel Güç',
      description: 'Akım Hesabı',
      latex: 'I = P / V',
      targetQuantityId: 'current_I',
      requiredQuantityIds: ['power_P', 'voltage_V'],
      isValid: (v) => v['voltage_V']! != 0,
      calculate: (v) => v['power_P']! / v['voltage_V']!,
    ),

    // ==========================================
    // 14. ELEKTRİKSEL YÜK (q = I * t)
    // ==========================================
    Formula(
      id: 'charge_from_It',
      groupName: 'Elektriksel Yük',
      description: 'Yük Hesabı',
      latex: 'q = I \\cdot t',
      targetQuantityId: 'charge_q',
      requiredQuantityIds: ['current_I', 'time_t'],
      calculate: (v) => v['current_I']! * v['time_t']!,
    ),
    Formula(
      id: 'current_from_qt',
      groupName: 'Elektriksel Yük',
      description: 'Akım Hesabı',
      latex: 'I = q / t',
      targetQuantityId: 'current_I',
      requiredQuantityIds: ['charge_q', 'time_t'],
      isValid: (v) => v['time_t']! != 0,
      calculate: (v) => v['charge_q']! / v['time_t']!,
    ),
    Formula(
      id: 'time_from_qI',
      groupName: 'Elektriksel Yük',
      description: 'Zaman Hesabı',
      latex: 't = q / I',
      targetQuantityId: 'time_t',
      requiredQuantityIds: ['charge_q', 'current_I'],
      isValid: (v) => v['current_I']! != 0,
      calculate: (v) => v['charge_q']! / v['current_I']!,
    ),
  ];
}
