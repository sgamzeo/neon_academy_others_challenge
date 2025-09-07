part of '../events.dart';

class _EventCardWidget extends StatelessWidget {
  final Event event;

  const _EventCardWidget({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = event.images != null && event.images!.isNotEmpty
        ? event.images!.first
        : null;

    return CustomCard(
      onTap: () => _showEventDetails(context),
      image: imageUrl != null
          ? CustomCachedImage(imageUrl: imageUrl, height: 120)
          : null,
      title: event.name ?? 'No Name',
      subtitle: event.startDate ?? 'No Date',
      imageHeight: 120,
      borderRadius: BorderRadius.circular(12),
    );
  }

  void _showEventDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _EventDetailsBottomSheet(event: event),
    );
  }
}
