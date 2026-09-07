import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

class ClientFormScreen extends StatefulWidget {
  final Client? client;
  final void Function(Client) onSave;
  const ClientFormScreen({super.key, this.client, required this.onSave});
  @override
  State<ClientFormScreen> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientFormScreen> {
  late final name = TextEditingController(text: widget.client?.name ?? '');
  late final phone = TextEditingController(text: widget.client?.phone ?? '');
  late final cpf = TextEditingController(text: widget.client?.cpf ?? '');
  late final email = TextEditingController(text: widget.client?.email ?? '');
  late final address = TextEditingController(
    text: widget.client?.address ?? '',
  );
  String? err;
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
          borderSide: const BorderSide(color: AppTheme.brand, width: 2),
        ),
      ),
    ),
  );
  void save() {
    if (name.text.trim().isEmpty) {
      setState(() => err = 'Nome obrigatório');
      return;
    }
    if (phone.text.trim().isEmpty) {
      setState(() => err = 'Telefone obrigatório');
      return;
    }
    widget.onSave(
      Client(
        id:
            widget.client?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.text.trim(),
        phone: phone.text.trim(),
        email: email.text.trim(),
        cpf: cpf.text.trim(),
        address: address.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text(widget.client == null ? 'Novo cliente' : 'Editar cliente'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          field('Nome', name, 'Ex: Ana Souza', required: true),
          field(
            'Telefone',
            phone,
            '(91) 99999-0000',
            required: true,
            type: TextInputType.phone,
          ),
          field('CPF', cpf, '000.000.000-00'),
          field(
            'E-mail',
            email,
            'exemplo@email.com',
            type: TextInputType.emailAddress,
          ),
          field('Endereço', address, 'Rua, número - Cidade, UF'),
          if (err != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                err!,
                style: const TextStyle(color: AppTheme.error, fontSize: 12),
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: save,
              icon: const Icon(Icons.check),
              label: Text(
                widget.client == null ? 'Salvar cliente' : 'Salvar alterações',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
