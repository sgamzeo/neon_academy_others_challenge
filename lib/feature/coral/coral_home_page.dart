import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_others_challenge/feature/coral/add_fragment_dialog.dart';
import 'package:neon_others_challenge/feature/coral/coral_fragment_list.dart';
import 'package:neon_others_challenge/feature/coral/cubit/coral_cubit.dart';
import 'package:neon_others_challenge/feature/coral/cubit/coral_state.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';

class CoralHomePage extends StatelessWidget {
  const CoralHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // load fragments when the page is built
    context.read<CoralCubit>().loadFragments();

    return Scaffold(
      appBar: AppBar(title: const Text('Coral Memory Fragments')),
      body: BlocBuilder<CoralCubit, CoralState>(
        builder: (context, state) {
          if (state is CoralLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CoralLoaded) {
            return CoralFragmentList(
              fragments: state.fragments,
              onEdit: (CoralFragment fragment) {
                // open dialog with edit functionality
                showDialog(
                  context: context,
                  builder: (_) => AddFragmentDialog(
                    onSubmit: (updatedFragment) {
                      context.read<CoralCubit>().updateFragment(
                        fragment.id,
                        title: updatedFragment.title,
                        species: updatedFragment.species,
                        details: updatedFragment.details,
                      );
                    },
                  ),
                );
              },
              onDelete: (CoralFragment fragment) {
                context.read<CoralCubit>().deleteFragment(fragment.id);
              },
            );
          } else if (state is CoralError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AddFragmentDialog(
        onSubmit: (fragment) {
          context.read<CoralCubit>().addFragment(fragment);
        },
      ),
    );
  }
}
