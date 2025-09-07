import 'package:custom_components/components/forms/form_manager.dart';
import 'package:flutter/material.dart';
import 'package:custom_components/custom_components.dart';
import 'package:neon_others_challenge/core/components/default_list_tile.dart';
import 'package:neon_others_challenge/core/helper/db_helper.dart';

part 'hero_form.dart';
part 'hero_list.dart';
part 'hero_list_tile.dart';

class HeroFormPage extends StatefulWidget {
  @override
  State<HeroFormPage> createState() => _HeroFormPageState();
}

class _HeroFormPageState extends State<HeroFormPage> {
  final formState = FormStateManager();
  late List<FormFieldData> fields;

  List<Map<String, dynamic>> heroes = [];
  int? editingId;

  @override
  void initState() {
    super.initState();

    fields = [
      FormFieldData(
        key: 'name',
        label: 'Name',
        hint: 'Enter name',
        validatorType: ValidatorType.required,
        fieldType: FieldType.text,
      ),
      FormFieldData(
        key: 'surname',
        label: 'Surname',
        hint: 'Enter surname',
        validatorType: ValidatorType.required,
        fieldType: FieldType.text,
      ),
      FormFieldData(
        key: 'age',
        label: 'Age',
        hint: 'Enter age',
        fieldType: FieldType.text,
      ),
      FormFieldData(
        key: 'email',
        label: 'Email',
        hint: 'Enter email',
        validatorType: ValidatorType.email,
        fieldType: FieldType.email,
      ),
    ];

    _loadHeroes();
  }

  void _loadHeroes() async {
    final data = await DBHelper().getHeroes();
    setState(() {
      heroes = data;
    });
  }

  Future<void> _onSubmit(Map<String, dynamic> values) async {
    if (editingId == null) {
      await DBHelper().insertHero({
        'name': values['name'],
        'surname': values['surname'],
        'age': int.parse(values['age']),
        'email': values['email'],
      });
    } else {
      await DBHelper().updateHero(editingId!, {
        'name': values['name'],
        'surname': values['surname'],
        'age': int.parse(values['age']),
        'email': values['email'],
      });
      editingId = null;
    }

    _clearForm();
    _loadHeroes();
  }

  void _editHero(Map<String, dynamic> hero) {
    setState(() {
      editingId = hero['id'];
      fields.firstWhere((f) => f.key == 'name').controller.text = hero['name'];
      fields.firstWhere((f) => f.key == 'surname').controller.text =
          hero['surname'];
      fields.firstWhere((f) => f.key == 'age').controller.text = hero['age']
          .toString();
      fields.firstWhere((f) => f.key == 'email').controller.text =
          hero['email'];
    });
  }

  void _deleteHero(int id) async {
    await DBHelper().deleteHero(id);
    _loadHeroes();
  }

  void _clearForm() {
    for (var field in fields) {
      field.controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neon Academy Heroes')),
      body: Column(
        children: [
          CustomForm(
            fields: fields,
            onSubmit: _onSubmit,
            formState: formState,
            submitText: editingId == null ? 'Save Hero' : 'Update Hero',
            title: editingId == null ? 'Add New Hero' : 'Edit Hero',
          ),
          const SizedBox(height: 20),
          const Text(
            'Saved Heroes:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: HeroList(
              heroes: heroes,
              onEdit: _editHero,
              onDelete: _deleteHero,
            ),
          ),
        ],
      ),
    );
  }
}
