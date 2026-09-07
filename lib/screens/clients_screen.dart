import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ClientsScreen extends StatefulWidget {
  final List<Client> clients;
  final void Function(Client) onDetail;
  final void Function(Client) onEdit;
  final void Function(Client) onDelete;
  final VoidCallback onNew;

  const ClientsScreen({
    super.key,
    required this.clients,
    required this.onDetail,
    required this.onEdit,
    required this.onDelete,
    required this.onNew,
  });

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final list = widget.clients.where((x) {
      final q = search.toLowerCase();

      return x.name.toLowerCase().contains(q) ||
          x.phone.contains(search) ||
          x.email.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        AppHeader(
          title: 'Clientes',
          actions: [
            IconButton(
              onPressed: widget.onNew,
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.brand,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          child: SearchBox(
            hint: 'Pesquisar cliente...',
            onChanged: (v) => setState(() => search = v),
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: AppTheme.brandContainer,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.people_outline,
                          size: 42,
                          color: AppTheme.onBrandContainer,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        search.isEmpty
                            ? 'Nenhum cliente'
                            : 'Nenhum resultado',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        search.isEmpty
                            ? 'Você ainda não possui clientes cadastrados.'
                            : 'Tente pesquisar com outro termo.',
                        style: const TextStyle(
                          color: AppTheme.muted,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final x = list[i];

                    return Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => widget.onDetail(x),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppTheme.brand,
                                child: Text(
                                  initials(x.name),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      x.phone,
                                      style: const TextStyle(
                                        color: AppTheme.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      x.email,
                                      style: const TextStyle(
                                        color: AppTheme.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => widget.onEdit(x),
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 19,
                                ),
                              ),
                              IconButton(
                                onPressed: () => widget.onDelete(x),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 19,
                                  color: AppTheme.error,
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: AppTheme.outline,
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