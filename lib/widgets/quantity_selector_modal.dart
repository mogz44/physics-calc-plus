import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import '../data/standard_quantities.dart';
import '../models/physics_category.dart';
import '../models/physics_quantity.dart';

/// Kullanıcının fiziksel büyüklüğü arayarak ve kategorilere göre seçmesini sağlayan Modal (TR/EN Destekli).
class QuantitySelectorModal extends StatefulWidget {
  final PhysicsQuantity? currentSelected;

  const QuantitySelectorModal({super.key, this.currentSelected});

  static Future<PhysicsQuantity?> show(
    BuildContext context, {
    PhysicsQuantity? currentSelected,
  }) {
    return showModalBottomSheet<PhysicsQuantity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => QuantitySelectorModal(currentSelected: currentSelected),
    );
  }

  @override
  State<QuantitySelectorModal> createState() => _QuantitySelectorModalState();
}

class _QuantitySelectorModalState extends State<QuantitySelectorModal> {
  final TextEditingController _searchController = TextEditingController();
  PhysicsCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PhysicsQuantity> _getFilteredQuantities(String langCode) {
    return StandardQuantities.all.where((q) {
      if (_selectedCategory != null && q.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isEmpty) return true;

      final query = _searchQuery.toLowerCase();
      final nameTr = q.name.toLowerCase();
      final nameEn = (q.nameEn ?? '').toLowerCase();
      final symbol = q.symbol.toLowerCase();
      final id = q.id.toLowerCase();

      return nameTr.contains(query) ||
          nameEn.contains(query) ||
          symbol.contains(query) ||
          id.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = context.loc;
    final filteredQuantities = _getFilteredQuantities(loc.languageCode);

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
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
                Text(
                  loc.selectQuantity,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Arama çubuğu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val.trim()),
              decoration: InputDecoration(
                hintText: loc.searchQuantityHint,
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Kategori filtre çipleri
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: Text(loc.all),
                  selected: _selectedCategory == null,
                  onSelected: (_) => setState(() => _selectedCategory = null),
                ),
                const SizedBox(width: 8),
                ...PhysicsCategory.values.map((cat) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text('${cat.icon} ${cat.getLocalizedLabel(loc.languageCode)}'),
                      selected: _selectedCategory == cat,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? cat : null;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          const Divider(height: 1),

          // Büyüklük listesi
          Expanded(
            child: filteredQuantities.isEmpty
                ? Center(
                    child: Text(
                      loc.noResults,
                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredQuantities.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemBuilder: (context, index) {
                      final item = filteredQuantities[index];
                      final isSelected = widget.currentSelected?.id == item.id;

                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: isSelected
                            ? theme.colorScheme.primary.withValues(alpha: 0.12)
                            : null,
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                          child: Text(item.icon, style: const TextStyle(fontSize: 18)),
                        ),
                        title: Text(
                          '${item.getLocalizedName(loc.languageCode)} (${item.symbol})',
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? theme.colorScheme.primary : null,
                          ),
                        ),
                        subtitle: Text(
                          '${item.category.getLocalizedLabel(loc.languageCode)} • SI: ${item.defaultUnitId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
                            : const Icon(Icons.chevron_right, size: 20),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
