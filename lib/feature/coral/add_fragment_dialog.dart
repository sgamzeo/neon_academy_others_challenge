import 'package:custom_components/components/forms/custom_form.dart';
import 'package:custom_components/components/forms/form_field_data.dart';
import 'package:custom_components/components/forms/form_manager.dart';
import 'package:custom_components/helpers/validator_helper.dart';
import 'package:flutter/material.dart';
import 'package:neon_others_challenge/models/coral_fragment.dart';

class AddFragmentDialog extends StatelessWidget {
  final void Function(CoralFragment fragment) onSubmit;

  const AddFragmentDialog({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final formState = FormStateManager();
    final fields = [
      FormFieldData(key: 'title', label: 'Title', fieldType: FieldType.text),
      FormFieldData(
        key: 'species',
        label: 'Species',
        fieldType: FieldType.text,
      ),
      FormFieldData(
        key: 'details',
        label: 'Details',
        fieldType: FieldType.text,
      ),
    ];

    return AlertDialog(
      title: const Text("Add Coral Fragment"),
      content: CustomForm(
        fields: fields,
        formState: formState,
        onSubmit: (values) async {
          final fragment = CoralFragment(
            title: values['title']!,
            species: values['species']!,
            details: values['details'] ?? '',
            date: DateTime.now(),
          );
          onSubmit(fragment);
          Navigator.pop(context);
        },
      ),
    );
  }
}
