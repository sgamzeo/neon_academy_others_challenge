part of 'form_page.dart';

class HeroForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController ageController;
  final TextEditingController emailController;
  final VoidCallback onSave;
  final int? editingId;

  const HeroForm({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.ageController,
    required this.emailController,
    required this.onSave,
    this.editingId,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: surnameController,
            decoration: const InputDecoration(labelText: 'Surname'),
          ),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSave,
            child: Text(editingId == null ? 'Save Hero' : 'Update Hero'),
          ),
        ],
      ),
    );
  }
}
