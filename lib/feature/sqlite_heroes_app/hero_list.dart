part of 'form_page.dart';

class HeroList extends StatelessWidget {
  final List<Map<String, dynamic>> heroes;
  final void Function(Map<String, dynamic>) onEdit;
  final void Function(int) onDelete;

  const HeroList({
    super.key,
    required this.heroes,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: heroes.length,
      itemBuilder: (context, index) {
        final hero = heroes[index];
        return HeroListTile(
          hero: hero,
          onEdit: () => onEdit(hero),
          onDelete: () => onDelete(hero['id']),
        );
      },
    );
  }
}
