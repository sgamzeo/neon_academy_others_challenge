import 'package:flutter/material.dart';
import 'package:custom_components/components/lists/custom_list_tile.dart';

class DefaultActionsListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DefaultActionsListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      title: title,
      subtitle: subtitle,
      actions: [
        CustomListTileAction(
          icon: const Icon(Icons.edit, color: Colors.orange),
          onPressed: onEdit,
        ),
        CustomListTileAction(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ],
    );
  }
}
