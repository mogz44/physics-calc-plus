import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../engine/inference_engine.dart';
import '../../models/inference_result.dart';
import '../../models/input_row_model.dart';
import '../widgets/input_row_widget.dart';
import 'solution_report_sheet.dart';

/// Physics Calc+ (Ana Ekran - Dinamik Çıkarım Motoru)
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
    final hasDerived = _currentResult != null && _currentResult!.hasDerivedValues;
    final derivedCount = _currentResult?.newlyDerivedQuantityIds.length ?? 0;

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
              child: Icon(Icons.calculate_rounded,
                  color: theme.colorScheme.primary, size: 22),
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
            // Bilgi ve Kolon Başlığı
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      'BÜYÜKLÜK',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'DEĞER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'BİRİM',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  if (_inputRows.length > 2) const SizedBox(width: 36),
                ],
              ),
            ),

            // Canlı Durum Bildirim Şeridi (Yeni değer türetildiğinde belirir)
            if (hasDerived)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.green, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$derivedCount yeni büyüklük zincirleme çözüldü!',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showReport,
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        foregroundColor: Colors.green,
                      ),
                      child: const Text('İncele'),
                    ),
                  ],
                ),
              ),

            // Dinamik Satırlar Listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
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
                color: theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // + Değer Ekle Butonu
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text(
                        'Değer Ekle',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
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
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        foregroundColor: hasDerived
                            ? Colors.white
                            : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
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
