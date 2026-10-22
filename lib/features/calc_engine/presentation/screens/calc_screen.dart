import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../engine/inference_engine.dart';
import '../../models/inference_result.dart';
import '../../models/input_row_model.dart';
import '../widgets/input_row_widget.dart';
import 'solution_report_sheet.dart';

/// Physics Calc+ (Ana Ekran - Dikey Kart Mimarili Dinamik Çıkarım Motoru)
class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  final _uuid = const Uuid();
  late final InferenceEngine _engine;
  final List<InputRowModel> _inputRows = [];
  InferenceResult? _currentResult;

  @override
  void initState() {
    super.initState();
    _engine = InferenceEngine();
    // Varsayılan olarak 2 satır ekle
    _addRow();
    _addRow();
  }

  void _addRow() {
    setState(() {
      _inputRows.add(InputRowModel(rowId: _uuid.v4()));
    });
  }

  void _removeRow(int index) {
    setState(() {
      _inputRows.removeAt(index);
    });
    _recalculate();
  }

  void _clearAll() {
    setState(() {
      _inputRows.clear();
      _addRow();
      _addRow();
      _currentResult = null;
    });
  }

  void _recalculate() {
    final validRows = _inputRows.where((r) => r.isValid).toList();
    if (validRows.isEmpty) {
      setState(() => _currentResult = null);
      return;
    }

    final result = _engine.solve(validRows);
    setState(() {
      _currentResult = result;
    });
  }

  void _showReport() {
    if (_currentResult != null) {
      SolutionReportSheet.show(context, _currentResult!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen geçerli veri büyüklüğü ve sayısal değer girin.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasDerived = _currentResult != null && _currentResult!.hasDerivedValues;
    final derivedCount = _currentResult?.newlyDerivedQuantityIds.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/icon/app_logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Physics Calc+'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Girdileri Temizle',
            onPressed: _clearAll,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Bilgi ve Başlık Satırı
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BİLİNEN DEĞERLER (${_inputRows.length})',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            // Canlı Durum Bildirim Şeridi (Yeni değer türetildiğinde belirir)
            if (hasDerived)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 6, 16, 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$derivedCount yeni büyüklük zincirleme çözüldü!',
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showReport,
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        foregroundColor: colorScheme.primary,
                      ),
                      child: const Text('İncele'),
                    ),
                  ],
                ),
              ),

            // Dinamik Dikey Satırlar Listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 6, bottom: 16),
                itemCount: _inputRows.length,
                itemBuilder: (context, index) {
                  return InputRowWidget(
                    key: ValueKey(_inputRows[index].rowId),
                    row: _inputRows[index],
                    canDelete: _inputRows.length > 1,
                    onChanged: _recalculate,
                    onDelete: () => _removeRow(index),
                  );
                },
              ),
            ),

            // Alt Aksiyon Alanı (+ Değer Ekle ve Sonuç Raporunu Gör Butonları)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outline, width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // + Değer Ekle Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.add, size: 20, color: colorScheme.primary),
                      label: Text(
                        'Değer Ekle',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: colorScheme.primary.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _addRow,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Sonuç Raporunu Gör Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.insights, size: 20),
                      label: Text(
                        hasDerived
                            ? 'Sonuç Raporunu Gör ($derivedCount Değer)'
                            : 'Sonuç Raporunu Gör',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasDerived
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        foregroundColor: hasDerived
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                        elevation: hasDerived ? 2 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: hasDerived ? _showReport : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
