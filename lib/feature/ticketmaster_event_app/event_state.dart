import 'package:neon_others_challenge/core/models/event_model.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;
  EventLoaded(this.events);
}

class EventError extends EventState {
  final String message;
  EventError(this.message);
}
