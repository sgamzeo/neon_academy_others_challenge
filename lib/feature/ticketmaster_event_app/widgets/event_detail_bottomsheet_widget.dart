part of '../events.dart';

class _EventDetailsBottomSheet extends StatelessWidget {
  final Event event;

  const _EventDetailsBottomSheet({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final properties = <Map<String, String>>[
      {'label': 'ID', 'value': event.id},
      if (event.name != null) {'label': 'Name', 'value': event.name!},
      if (event.type != null) {'label': 'Type', 'value': event.type!},
      if (event.url != null) {'label': 'URL', 'value': event.url!},
      if (event.locale != null) {'label': 'Locale', 'value': event.locale!},
      if (event.city != null) {'label': 'City', 'value': event.city!},
      if (event.country != null) {'label': 'Country', 'value': event.country!},
      if (event.venue != null) {'label': 'Venue', 'value': event.venue!},
      if (event.classification != null)
        {'label': 'Classification', 'value': event.classification!},
      if (event.priceMin != null)
        {'label': 'Price Min', 'value': event.priceMin!.toString()},
      if (event.priceMax != null)
        {'label': 'Price Max', 'value': event.priceMax!.toString()},
      if (event.timezone != null)
        {'label': 'Timezone', 'value': event.timezone!},
      if (event.startDate != null)
        {'label': 'Start Date', 'value': event.startDate!},
      if (event.description != null)
        {'label': 'Description', 'value': event.description!},
      if (event.info != null) {'label': 'Info', 'value': event.info!},
      if (event.promoter != null)
        {'label': 'Promoter', 'value': event.promoter!},
    ];

    return CustomBottomSheet(
      title: event.name ?? 'Event Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: properties
            .map(
              (prop) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    text: '${prop['label']}: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: prop['value'],
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
