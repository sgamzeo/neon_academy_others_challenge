import 'package:flutter/material.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';

import 'package:neon_others_challenge/core/components/default_list_tile.dart';

class CoralFragmentTile extends StatelessWidget {
  final CoralFragment fragment;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CoralFragmentTile({
    super.key,
    required this.fragment,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultActionsListTile(
      title: fragment.title,
      subtitle: fragment.species,
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}
