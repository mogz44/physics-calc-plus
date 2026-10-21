import 'package:flutter/material.dart';
import '../../../common_physics/data/standard_units.dart';
import '../../../common_physics/models/physics_unit.dart';
import '../../models/input_row_model.dart';
import 'quantity_selector_modal.dart';

/// Dinamik 3 Kolonlu Girdi Satırı Bileşeni:
/// [Sol Kolon: Veri Tipi Seçici] | [Orta Kolon: Miktar TextField] | [Sağ Kolon: Birim Dropdown]
class InputRowWidget extends StatefulWidget {
  final InputRowModel row;
  final VoidCallback onChanged;
  final VoidCallback onDelete;
  final bool canDelete;

  const InputRowWidget({
    super.key,
    required this.row,
    required this.onChanged,
    required this.onDelete,
    this.canDelete = true,
  });

  @override
  State<InputRowWidget> createState() => _InputRowWidgetState();
}

class _InputRowWidgetState extends State<InputRowWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.row.value != null ? widget.row.value.toString() : '',
    );
  }

  @override
  void didUpdateWidget(covariant InputRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.row.value != null &&
        double.tryParse(_controller.text) != widget.row.value) {
      _controller.text = widget.row.value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickQuantity() async {
    final selected = await QuantitySelectorModal.show(
      context,
      currentSelected: widget.row.quantity,
    );

    if (selected != null && selected != widget.row.quantity) {
      setState(() {
        widget.row.quantity = selected;
        // Büyüklük değiştiğinde varsayılan SI birimini ata
        final units = StandardUnits.getUnitsForQuantity(selected.id);
        widget.row.selectedUnit =
            units.where((u) => u.isSi).firstOrNull ?? units.firstOrNull;
      });
      widget.onChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableUnits = widget.row.quantity != null
        ? StandardUnits.getUnitsForQuantity(widget.row.quantity!.id)
        : <PhysicsUnit>[];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. SOL KOLON: Veri Tipi Seçici
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: _pickQuantity,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (widget.row.quantity != null) ...[
                        Text(widget.row.quantity!.icon,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${widget.row.quantity!.name} (${widget.row.quantity!.symbol})',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ] else ...[
                        const Icon(Icons.add_circle_outline, size: 18),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Büyüklük Seç',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      const Icon(Icons.arrow_drop_down, size: 18),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // 2. ORTA KOLON: Miktar Girdisi (TextField)
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: _controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0.0',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onChanged: (text) {
                    final parsed = double.tryParse(text.replaceAll(',', '.'));
                    widget.row.value = parsed;
                    widget.onChanged();
                  },
                ),
              ),
            ),

            const SizedBox(width: 8),

            // 3. SAĞ KOLON: Birim Seçici
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 48,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<PhysicsUnit>(
                      value: availableUnits.contains(widget.row.selectedUnit)
                          ? widget.row.selectedUnit
                          : null,
                      isExpanded: true,
                      hint: const Text(
                        'Birim',
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: availableUnits.map((u) {
                        return DropdownMenuItem<PhysicsUnit>(
                          value: u,
                          child: Text(
                            u.symbol,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  u.isSi ? FontWeight.bold : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (newUnit) {
                        if (newUnit != null) {
                          setState(() {
                            widget.row.selectedUnit = newUnit;
                          });
                          widget.onChanged();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Satır Silme Butonu
            if (widget.canDelete) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Colors.redAccent, size: 20),
                tooltip: 'Satırı Sil',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: widget.onDelete,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
