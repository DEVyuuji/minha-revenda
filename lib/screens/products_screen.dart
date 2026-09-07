import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProductsScreen extends StatefulWidget {
  final List<Product> products;
  final void Function(Product) onDetail;
  final void Function(Product) onEdit;
  final void Function(Product) onDelete;
  final VoidCallback onNew;

  const ProductsScreen({
    super.key,
    required this.products,
    required this.onDetail,
    required this.onEdit,
    required this.onDelete,
    required this.onNew,
  });

  @override
  State<ProductsScreen> createState() => _ProductsState();
}

class _ProductsState extends State<ProductsScreen> {
  String search = '';

  Color cat(String s) {
    switch (s) {
      case 'Perfumaria':
        return const Color(0xFFF3E5F5);
      case 'Cuidados Faciais':
        return const Color(0xFFFFF3E0);
      case 'Maquiagem':
        return const Color(0xFFFCE4EC);
      default:
        return AppTheme.brandContainer;
    }
  }

  Color catText(String s) {
    switch (s) {
      case 'Perfumaria':
        return const Color(0xFF7B1FA2);
      case 'Cuidados Faciais':
        return const Color(0xFFE65100);
      case 'Maquiagem':
        return const Color(0xFFC62828);
      default:
        return AppTheme.onBrandContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.products.where((x) {
      final q = search.toLowerCase();

      return x.name.toLowerCase().contains(q) ||
          x.brand.toLowerCase().contains(q) ||
          x.category.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        AppHeader(
          title: 'Produtos',
          actions: [
            IconButton(
              onPressed: widget.onNew,
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          child: SearchBox(
            hint: 'Pesquisar produto...',
            onChanged: (v) => setState(() => search = v),
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(
                  child: Text('Nenhum produto'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final p = list[i];

                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => widget.onDetail(p),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            13,
                            13,
                            9,
                            10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: AppTheme.tertiaryContainer,
                                      borderRadius:
                                          BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.inventory_2_outlined,
                                      color:
                                          AppTheme.onTertiaryContainer,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          p.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          p.brand,
                                          style: const TextStyle(
                                            color: AppTheme.muted,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          brl(p.salePrice),
                                          style: const TextStyle(
                                            color: AppTheme.brand,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Estoque: ${p.quantity}',
                                          style: const TextStyle(
                                            color: AppTheme.muted,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => widget.onEdit(p),
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => widget.onDelete(p),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                      color: AppTheme.error,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppTheme.outline,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cat(p.category),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    p.category,
                                    style: TextStyle(
                                      color: catText(p.category),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}