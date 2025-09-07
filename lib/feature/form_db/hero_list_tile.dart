part of 'form_page.dart';

class HeroListTile extends StatelessWidget {
  final Map<String, dynamic> hero;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HeroListTile({
    super.key,
    required this.hero,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultActionsListTile(
      title: '${hero['name']} ${hero['surname']}',
      subtitle: 'Age: ${hero['age']} Email: ${hero['email']}',
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }
}
