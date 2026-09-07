import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit, onDelete;
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });
  Widget row(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppTheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: AppTheme.onTertiaryContainer),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value.isEmpty ? 'Não informado' : value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext c) => Column(
    children: [
      AppHeader(
        title: 'Detalhes do produto',
        onBack: () => Navigator.pop(c),
        actions: [
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: AppTheme.error),
          ),
        ],
      ),
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.sell_outlined,
                    size: 36,
                    color: AppTheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.tertiary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    product.brand,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Price('Custo', brl(product.costPrice), false),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Price('Venda', brl(product.salePrice), true),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        row(Icons.business_outlined, 'Marca', product.brand),
                        const Divider(height: 1),
                        row(
                          Icons.qr_code_2_outlined,
                          'Código / SKU',
                          product.sku,
                        ),
                        const Divider(height: 1),
                        row(
                          Icons.tag_outlined,
                          'Estoque',
                          '${product.quantity} unidades',
                        ),
                        const Divider(height: 1),
                        row(
                          Icons.layers_outlined,
                          'Categoria',
                          product.category,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class Price extends StatelessWidget {
  final String label, value;
  final bool highlight;
  const Price(this.label, this.value, this.highlight, {super.key});
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: highlight ? AppTheme.brandContainer : Colors.white,
      border: Border.all(color: AppTheme.outlineVariant),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: highlight ? AppTheme.onBrandContainer : AppTheme.muted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: highlight ? AppTheme.onBrandContainer : AppTheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
