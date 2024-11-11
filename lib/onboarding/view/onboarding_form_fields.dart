import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required GlobalKey<FormState> formKey,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: (value) {
        formKey.currentState
            ?.validate(); // Forzar validación y actualizar estado
      },
    ),
  );
}

Widget buildDateField({
  required TextEditingController controller,
  required String label,
  required BuildContext context,
  required Future<void> Function(BuildContext) selectDate,
  required GlobalKey<FormState> formKey,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => selectDate(context),
      validator: (value) =>
          value?.isEmpty ?? true ? 'Debes seleccionar una fecha' : null,
    ),
  );
}
