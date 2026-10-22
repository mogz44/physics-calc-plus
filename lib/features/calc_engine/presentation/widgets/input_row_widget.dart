import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common_physics/data/standard_units.dart';
import '../../../common_physics/models/physics_unit.dart';
import '../../models/input_row_model.dart';
import 'quantity_selector_modal.dart';

/// Dikey Kart (Stacked) Mimarisine Sahip Girdi Satırı Bileşeni:
/// - Üst Satır:
///     Sol: Büyüklük Adı (Tam genişlikte, ikon ve sembol ile)
///     Sağ: Silme Butonu
/// - Alt Satır:
///     Sol (%65 genişlik): Sayısal değer girişi TextField
///     Sağ (%35 genişlik): Birim seçici DropdownButton
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
        double.tryParse(_controller.text.replaceAll(',', '.')) !=
            widget.row.value) {
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
    final colorScheme = theme.colorScheme;
    final availableUnits = widget.row.quantity != null
        ? StandardUnits.getUnitsForQuantity(widget.row.quantity!.id)
        : <PhysicsUnit>[];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // 1. ÜST SATIR: Büyüklük Seçici (Sol) & Silme Butonu (Sağ)
            // ==========================================
            Row(
              children: [
                // Sol: Büyüklük Seçici (Geniş alan, kırpılmayı önler)
                Expanded(
                  child: InkWell(
                    onTap: _pickQuantity,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          if (widget.row.quantity != null) ...[
                            Text(
                              widget.row.quantity!.icon,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${widget.row.quantity!.name} (${widget.row.quantity!.symbol})',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ] else ...[
                            Icon(
                              Icons.add_circle_outline,
                              size: 18,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Fiziksel Büyüklük Seç',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Sağ: Silme Butonu
                if (widget.canDelete)
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: Colors.redAccent.withValues(alpha: 0.85),
                    ),
                    tooltip: 'Satırı Sil',
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    onPressed: widget.onDelete,
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // ==========================================
            // 2. ALT SATIR: Değer Girişi (%65) & Birim Dropdown (%35)
            // ==========================================
            Row(
              children: [
                // Sol (%65 genişlik): Sayısal Değer Girişi
                Expanded(
                  flex: 65,
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^-?[0-9]*[.,]?[0-9]*'),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Değer girin (örn: 10.5)',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (text) {
                        final parsed =
                            double.tryParse(text.replaceAll(',', '.'));
                        widget.row.value = parsed;
                        widget.onChanged();
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Sağ (%35 genişlik): Birim Seçici Dropdown
                Expanded(
                  flex: 35,
                  child: SizedBox(
                    height: 48,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor ??
                            colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<PhysicsUnit>(
                          value: availableUnits.contains(widget.row.selectedUnit)
                              ? widget.row.selectedUnit
                              : null,
                          isExpanded: true,
                          dropdownColor: colorScheme.surface,
                          hint: Text(
                            'Birim',
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          icon: Icon(
                            Icons.unfold_more_rounded,
                            size: 18,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          items: availableUnits.map((u) {
                            return DropdownMenuItem<PhysicsUnit>(
                              value: u,
                              child: Text(
                                u.symbol,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: u.isSi
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: u.isSi
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
