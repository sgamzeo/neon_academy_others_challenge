import 'package:custom_components/components/cards/custom_card.dart';
import 'package:custom_components/components/custom_cached_image.dart';
import 'package:custom_components/components/sheets/custom_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_components/components/lists/custom_grid_view.dart';
import 'package:neon_others_challenge/feature/ticketmaster_event_app/event_cubit.dart';
import 'package:neon_others_challenge/feature/ticketmaster_event_app/event_state.dart';
import 'package:neon_others_challenge/core/models/event_model.dart';

part 'widgets/event_card_widget.dart';
part 'widgets/event_detail_bottomsheet_widget.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCubit>();
    cubit.fetchEvents(keyword: "music", countryCode: "TR");

    return Scaffold(
      appBar: AppBar(title: const Text("Ticketmaster Events")),
      body: RefreshIndicator(
        onRefresh: () async {
          await cubit.fetchEvents(keyword: "music", countryCode: "TR");
        },
        child: BlocBuilder<EventCubit, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              final events = state.events;

              if (events.isEmpty) {
                return const Center(child: Text("No events found."));
              }

              return CustomGridView<Event>(
                items: events,
                crossAxisCount: 2,

                childAspectRatio: 0.7,
                itemBuilder: (context, event, index, isSelected) {
                  return _EventCardWidget(event: event);
                },
                onItemTap: (index) {},
              );
            } else if (state is EventError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
