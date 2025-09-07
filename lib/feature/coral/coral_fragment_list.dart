import 'package:flutter/material.dart';
import 'package:neon_others_challenge/feature/coral/coral_fragment_tile.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';

class CoralFragmentList extends StatelessWidget {
  final List<CoralFragment> fragments;
  final void Function(CoralFragment fragment) onEdit;
  final void Function(CoralFragment fragment) onDelete;

  const CoralFragmentList({
    super.key,
    required this.fragments,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (fragments.isEmpty) {
      return const Center(child: Text("No fragments yet."));
    }

    return ListView.builder(
      itemCount: fragments.length,
      itemBuilder: (context, index) {
        final f = fragments[index];
        return CoralFragmentTile(
          fragment: f,
          onEdit: () => onEdit(f),
          onDelete: () => onDelete(f),
        );
      },
    );
  }
}
