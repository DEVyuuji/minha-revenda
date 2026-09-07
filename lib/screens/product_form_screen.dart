import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final void Function(Product) onSave;
  const ProductFormScreen({super.key, this.product, required this.onSave});
  @override
  State<ProductFormScreen> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductFormScreen> {
  late final name = TextEditingController(text: widget.product?.name ?? '');
  late final brand = TextEditingController(text: widget.product?.brand ?? '');
  late final sku = TextEditingController(text: widget.product?.sku ?? '');
  late final cost = TextEditingController(
    text: widget.product?.costPrice.toStringAsFixed(2) ?? '',
  );
  late final sale = TextEditingController(
    text: widget.product?.salePrice.toStringAsFixed(2) ?? '',
  );
  late final qty = TextEditingController(
    text: widget.product?.quantity.toString() ?? '',
  );
  String category = '';
  String? err;
  final cats = [
    'Cuidados Corporais',
    'Cuidados Faciais',
    'Perfumaria',
    'Maquiagem',
    'Cabelos',
    'Outros',
  ];
  @override
  void initState() {
    super.initState();
    category = widget.product?.category ?? '';
  }

  Widget field(
    String label,
    TextEditingController c,
    String hint, {
    bool required = false,
    TextInputType? type,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextField(
      controller: c,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        filled: true,
        fillColor: AppTheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppTheme.outlineVariant,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppTheme.tertiary, width: 2),
        ),
      ),
    ),
  );
  void save() {
    if (name.text.trim().isEmpty) {
      setState(() => err = 'Nome obrigatório');
      return;
    }
    if (brand.text.trim().isEmpty) {
      setState(() => err = 'Marca obrigatória');
      return;
    }
    widget.onSave(
      Product(
        id:
            widget.product?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.text.trim(),
        brand: brand.text.trim(),
        sku: sku.text.trim(),
        costPrice: double.tryParse(cost.text.replaceAll(',', '.')) ?? 0,
        salePrice: double.tryParse(sale.text.replaceAll(',', '.')) ?? 0,
        quantity: int.tryParse(qty.text) ?? 0,
        category: category.isEmpty ? 'Outros' : category,
      ),
    );
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text(widget.product == null ? 'Novo produto' : 'Editar produto'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          field('Nome', name, 'Ex: Hidratante Corporal', required: true),
          field('Marca', brand, 'Ex: Natura', required: true),
          field('Código / SKU', sku, 'Ex: NAT-001'),
          Row(
            children: [
              Expanded(
                child: field(
                  'Preço de custo',
                  cost,
                  '0,00',
                  type: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: field(
                  'Preço de venda',
                  sale,
                  '0,00',
                  type: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
          field('Quantidade', qty, '0', type: TextInputType.number),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'CATEGORIA',
              style: TextStyle(
                color: AppTheme.muted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: cats
                .map(
                  (x) => ChoiceChip(
                    label: Text(x),
                    selected: category == x,
                    onSelected: (_) => setState(() => category = x),
                    selectedColor: AppTheme.tertiaryContainer,
                    labelStyle: TextStyle(
                      color: category == x
                          ? AppTheme.onTertiaryContainer
                          : AppTheme.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
          if (err != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  err!,
                  style: const TextStyle(color: AppTheme.error, fontSize: 12),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: AppTheme.tertiary),
              onPressed: save,
              icon: const Icon(Icons.check),
              label: Text(
                widget.product == null ? 'Salvar produto' : 'Salvar alterações',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
