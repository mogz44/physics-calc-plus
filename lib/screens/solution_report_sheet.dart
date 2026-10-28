import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../core/localization/app_localizations.dart';
import '../core/utils/number_formatter.dart';
import '../data/standard_quantities.dart';
import '../data/standard_units.dart';
import '../models/inference_result.dart';

/// Hesaplama sonucunu ve Adım Adım Çözüm Ağacını sunan Rapor Sayfası / Modal (TR/EN Destekli).
class SolutionReportSheet extends StatelessWidget {
  final InferenceResult result;

  const SolutionReportSheet({super.key, required this.result});

  static void show(BuildContext context, InferenceResult result) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SolutionReportSheet(result: result),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = context.loc;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Tutma çubuğu
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 8),
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Başlık
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.analytics_outlined,
                          color: theme.colorScheme.primary, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.solutionReport,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          loc.chainedInferenceEngine,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 1. TÜRETİLEN DEĞERLER KARTI
                _buildDerivedSummaryCard(context),

                const SizedBox(height: 20),

                // 2. ADIM ADIM ÇÖZÜM AĞACI BAŞLIĞI
                Row(
                  children: [
                    Icon(Icons.account_tree_outlined,
                        size: 20, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      loc.solutionTreeTitle,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        loc.stepsCount(result.steps.length),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ADIMLAR LİSTESİ
                if (result.steps.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          loc.noDerivedQuantitiesWarning,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  ...result.steps.map((step) => _buildStepCard(context, step)),

                const SizedBox(height: 24),

                // 3. BAŞLANGIÇTA GİRİLEN VERİLER KARTI
                _buildInitialInputsCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDerivedSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    if (result.newlyDerivedQuantityIds.isEmpty) {
      return Card(
        color: Colors.amber.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.amber.withValues(alpha: 0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.amber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  loc.noDerivedQuantitiesWarning,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      color: theme.colorScheme.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  loc.derivedQuantitiesTitle(result.newlyDerivedQuantityIds.length),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: result.newlyDerivedQuantityIds.map((qId) {
                final q = StandardQuantities.getById(qId);
                final val = result.allKnownValues[qId]!;
                final siUnit = StandardUnits.getSiUnit(qId);

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(q?.icon ?? '📌', style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        '${q?.symbol ?? qId}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${NumberFormatter.format(val)} ${siUnit?.symbol ?? ''}',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, dynamic step) {
    final theme = Theme.of(context);
    final loc = context.loc;
    final targetQ = StandardQuantities.getById(step.targetQuantityId);
    final siUnit = StandardUnits.getSiUnit(step.targetQuantityId);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adım Başlığı & Formül Adı
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  child: Text(
                    '${step.stepIndex}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.formula.getLocalizedGroupName(loc.languageCode),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MarkdownBody(
                        data: _cleanMathSymbols(
                          step.formula.getLocalizedDescription(loc.languageCode),
                        ),
                        styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                          p: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodySmall?.color
                                ?.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MarkdownBody(
                    data: _formatMathMarkdown(step.formula.latex),
                    styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                      p: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),

            // Kullanılan Girdiler & Sonuç
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Girdiler
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.usedParameters,
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: (step.usedInputs as Map<String, double>)
                            .entries
                            .map((e) {
                          final inQ = StandardQuantities.getById(e.key);
                          final inUnit = StandardUnits.getSiUnit(e.key);
                          return Text(
                            '${inQ?.symbol ?? e.key} = ${NumberFormatter.format(e.value)} ${inUnit?.symbol ?? ''}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Bulunan Değer
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${targetQ?.getLocalizedName(loc.languageCode) ?? ''} (${targetQ?.symbol ?? ''})',
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        '${NumberFormatter.format(step.calculatedValue)} ${siUnit?.symbol ?? ''}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialInputsCard(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.initialInputsNormalized,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: result.initialKnownValues.entries.map((e) {
            final q = StandardQuantities.getById(e.key);
            final unit = StandardUnits.getSiUnit(e.key);
            return Chip(
              avatar: Text(q?.icon ?? '📌'),
              label: Text(
                '${q?.symbol ?? e.key}: ${NumberFormatter.format(e.value)} ${unit?.symbol ?? ''}',
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: theme.cardColor,
            );
          }).toList(),
        ),
      ],
    );
  }

  static String _cleanMathSymbols(String text) {
    return text
        .replaceAll(r'\cdot', '·')
        .replaceAll(r'\Delta', 'Δ')
        .replaceAll(r'\rho', 'ρ')
        .replaceAll(r'\theta', 'θ')
        .replaceAll(r'\pi', 'π')
        .replaceAll(r'\times', '×');
  }

  static String _formatMathMarkdown(String latex) {
    final cleaned = _cleanMathSymbols(latex);
    return '`$cleaned`';
  }
}
