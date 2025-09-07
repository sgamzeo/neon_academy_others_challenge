import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_others_challenge/core/models/event_model.dart';
import 'package:neon_others_challenge/core/services/ticketmaster_service.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final TicketmasterService service;

  EventCubit(this.service) : super(EventInitial());

  Future<void> fetchEvents({
    String? keyword,
    String? countryCode,
    String? classificationName,
    String? source,
    String? attractionId,
    String? dmaId,
  }) async {
    emit(EventLoading());
    try {
      final rawEvents = await service.fetchEvents(
        keyword: keyword,
        countryCode: countryCode,
        classificationName: classificationName,
        source: source,
        attractionId: attractionId,
        dmaId: dmaId,
      );

      // Map -> Event model
      final events = rawEvents.map((e) => Event.fromMap(e)).toList();
      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError("Failed to fetch events"));
    }
  }
}
