import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../calc_engine/presentation/widgets/quantity_selector_modal.dart';
import '../../../common_physics/data/standard_quantities.dart';
import '../../../common_physics/data/standard_units.dart';
import '../../../common_physics/models/physics_quantity.dart';
import '../../../common_physics/models/physics_unit.dart';

/// 2. Menü: Physics Converter (Birim Dönüştürücü - TR/EN Destekli)
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late PhysicsQuantity _selectedQuantity;
  late List<PhysicsUnit> _availableUnits;
  PhysicsUnit? _fromUnit;
  PhysicsUnit? _toUnit;
  final TextEditingController _inputController = TextEditingController(text: '1');
  double _inputValue = 1.0;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = StandardQuantities.velocity;
    _updateUnits();
  }

  void _updateUnits() {
    _availableUnits = StandardUnits.getUnitsForQuantity(_selectedQuantity.id);
    _fromUnit = _availableUnits.where((u) => !u.isSi).firstOrNull ?? _availableUnits.firstOrNull;
    _toUnit = _availableUnits.where((u) => u.isSi).firstOrNull ?? _availableUnits.firstOrNull;
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
  }

  double? get _convertedValue {
    if (_fromUnit == null || _toUnit == null) return null;
    final siVal = _fromUnit!.toSi(_inputValue);
    return _toUnit!.fromSi(siVal);
  }

  Future<void> _pickQuantity() async {
    final picked = await QuantitySelectorModal.show(
      context,
      currentSelected: _selectedQuantity,
    );
    if (picked != null && picked != _selectedQuantity) {
      setState(() {
        _selectedQuantity = picked;
        _updateUnits();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;
    final converted = _convertedValue;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.sync_alt_rounded,
                  color: theme.colorScheme.primary, size: 22),
            ),
            const SizedBox(width: 10),
            Text(loc.converterTitle),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Büyüklük Seçici Kartı
          Card(
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Text(_selectedQuantity.icon, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(
                loc.quantityToConvert,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              subtitle: Text(
                '${_selectedQuantity.getLocalizedName(loc.languageCode)} (${_selectedQuantity.symbol})',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
              onTap: _pickQuantity,
            ),
          ),

          const SizedBox(height: 16),

          // Değer Girdisi & Birim Seçiciler
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Sayısal Girdi
                  TextField(
                    controller: _inputController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: loc.valueToConvert,
                      prefixIcon: const Icon(Icons.edit_outlined),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _inputValue = double.tryParse(text.replaceAll(',', '.')) ?? 0.0;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Kaynak Birim -> Hedef Birim (Swap ile)
                  Row(
                    children: [
                      // Kaynak Birim
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.colorScheme.outline),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<PhysicsUnit>(
                              value: _fromUnit,
                              isExpanded: true,
                              dropdownColor: theme.colorScheme.surface,
                              items: _availableUnits.map((u) {
                                return DropdownMenuItem(
                                  value: u,
                                  child: Text(
                                    '${u.symbol} (${u.getLocalizedName(loc.languageCode)})',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() => _fromUnit = val),
                            ),
                          ),
                        ),
                      ),

                      // Birimleri Değiş Tokuş Butonu
                      IconButton(
                        icon: const Icon(Icons.swap_horiz_rounded),
                        tooltip: loc.swapUnits,
                        onPressed: _swapUnits,
                      ),

                      // Hedef Birim
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: theme.colorScheme.outline),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<PhysicsUnit>(
                              value: _toUnit,
                              isExpanded: true,
                              dropdownColor: theme.colorScheme.surface,
                              items: _availableUnits.map((u) {
                                return DropdownMenuItem(
                                  value: u,
                                  child: Text(
                                    '${u.symbol} (${u.getLocalizedName(loc.languageCode)})',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() => _toUnit = val),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Ana Sonuç Kartı
          if (converted != null && _fromUnit != null && _toUnit != null)
            Card(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    Text(
                      '${NumberFormatter.format(_inputValue)} ${_fromUnit!.symbol} =',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${NumberFormatter.format(converted)} ${_toUnit!.symbol}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _toUnit!.getLocalizedName(loc.languageCode),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          // Tüm Birimlere Toplu Eşdeğer Tablosu
          if (_fromUnit != null) ...[
            Text(
              loc.allEquivalentUnits(_selectedQuantity.getLocalizedName(loc.languageCode)),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _availableUnits.length,
                separatorBuilder: (context, idx) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final u = _availableUnits[index];
                  final siVal = _fromUnit!.toSi(_inputValue);
                  final valInThisUnit = u.fromSi(siVal);
                  final isCurrent = u.id == _toUnit?.id;

                  return ListTile(
                    dense: true,
                    tileColor: isCurrent ? theme.colorScheme.primary.withValues(alpha: 0.08) : null,
                    title: Text(
                      u.getLocalizedName(loc.languageCode),
                      style: TextStyle(fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal),
                    ),
                    subtitle: u.isSi ? Text(loc.siBaseUnit, style: const TextStyle(fontSize: 11, color: Colors.green)) : null,
                    trailing: Text(
                      '${NumberFormatter.format(valInThisUnit)} ${u.symbol}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCurrent ? theme.colorScheme.primary : null,
                      ),
                    ),
                    onTap: () {
                      setState(() => _toUnit = u);
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
