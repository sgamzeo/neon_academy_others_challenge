import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';
import 'package:neon_others_challenge/main.dart'; // objectbox
import 'coral_state.dart';

class CoralCubit extends Cubit<CoralState> {
  CoralCubit() : super(CoralInitial());

  // loads all coral fragments from the database
  void loadFragments() {
    emit(CoralLoading());
    try {
      final fragments = List<CoralFragment>.from(objectBox.coralBox.getAll());
      emit(CoralLoaded(fragments));
    } catch (e) {
      emit(CoralError("failed to load fragments: $e"));
    }
  }

  // adds a new coral fragment to the database
  void addFragment(CoralFragment fragment) {
    try {
      objectBox.coralBox.put(fragment); // add new fragment
      final fragments = List<CoralFragment>.from(objectBox.coralBox.getAll());
      emit(CoralLoaded(fragments));
    } catch (e) {
      emit(CoralError("failed to add fragment: $e"));
    }
  }

  // updates an existing coral fragment (or adds it if it doesn't exist)
  void updateFragment(
    int id, {
    required String title,
    required String species,
    String? details,
  }) {
    try {
      // get the existing fragment by id
      final fragment = objectBox.coralBox.get(id);
      if (fragment == null) {
        emit(CoralError("fragment not found"));
        return;
      }

      // update fields
      fragment.title = title;
      fragment.species = species;
      fragment.details = details ?? fragment.details;

      // save updated fragment
      objectBox.coralBox.put(fragment);

      // emit updated list
      final fragments = List<CoralFragment>.from(objectBox.coralBox.getAll());
      emit(CoralLoaded(fragments));
    } catch (e) {
      emit(CoralError("failed to update fragment: $e"));
    }
  }

  // deletes a coral fragment by its id
  void deleteFragment(int id) {
    try {
      objectBox.coralBox.remove(id);
      final fragments = List<CoralFragment>.from(objectBox.coralBox.getAll());
      emit(CoralLoaded(fragments));
    } catch (e) {
      emit(CoralError("failed to delete fragment: $e"));
    }
  }
}
