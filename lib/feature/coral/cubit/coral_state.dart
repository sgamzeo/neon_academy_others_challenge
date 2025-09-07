import 'package:equatable/equatable.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';

abstract class CoralState extends Equatable {
  const CoralState();

  @override
  List<Object?> get props => [];
}

class CoralInitial extends CoralState {}

class CoralLoading extends CoralState {}

class CoralLoaded extends CoralState {
  final List<CoralFragment> fragments;

  CoralLoaded(List<CoralFragment> fragments)
    : fragments = List.unmodifiable(fragments);

  @override
  List<Object?> get props => [fragments];
}

class CoralError extends CoralState {
  final String message;

  const CoralError(this.message);

  @override
  List<Object?> get props => [message];
}
