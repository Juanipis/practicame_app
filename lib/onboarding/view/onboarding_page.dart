import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:practicame_app/onboarding/view/onboarding_form_fields.dart';
import 'package:practicame_app/onboarding/view/onboarding_form_state.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingFormState _formState = OnboardingFormState();

  @override
  void dispose() {
    _formState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completa tu perfil'),
      ),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingTeacherMode) {
            return _buildForm(
              context: context,
              title: 'Añadir Estudiante',
              buttonText: 'Añadir Estudiante',
              onSave: () {
                final user = _createUserModel();
                context.read<OnboardingCubit>().addStudent(user);
              },
            );
          } else if (state is OnboardingStudentMode) {
            return _buildForm(
              context: context,
              title: 'Completa tu perfil',
              buttonText: 'Guardar Perfil',
              onSave: () {
                final user = _createUserModel();
                context.read<OnboardingCubit>().completeStudentProfile(user);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildForm({
    required BuildContext context,
    required String title,
    required String buttonText,
    required VoidCallback onSave,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formState.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formState.nameController,
                label: 'Nombre',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
                formKey: _formState.formKey,
              ),
              buildTextField(
                controller: _formState.lastNameController,
                label: 'Apellido',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
                formKey: _formState.formKey,
              ),
              buildTextField(
                controller: _formState.documentController,
                label: 'Número de Documento',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                formKey: _formState.formKey,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              buildDateField(
                controller: _formState.birthDateController,
                label: 'Fecha de Nacimiento',
                context: context,
                selectDate: _selectDate,
                formKey: _formState.formKey,
              ),
              buildTextField(
                controller: _formState.ageController,
                label: 'Edad',
                keyboardType: TextInputType.number,
                formKey: _formState.formKey,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              DropdownButtonFormField<EPS>(
                isExpanded: true,
                value: _formState.selectedEPS,
                decoration: const InputDecoration(labelText: 'EPS'),
                items: EPS.values.map((eps) {
                  return DropdownMenuItem<EPS>(
                    value: eps,
                    child: Text(eps.name),
                  );
                }).toList(),
                onChanged: (EPS? newValue) {
                  setState(() {
                    _formState.selectedEPS = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Debes seleccionar una EPS' : null,
              ),
              buildTextField(
                controller: _formState.bloodTypeController,
                formKey: _formState.formKey,
                label: 'Tipo de Sangre',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              buildTextField(
                controller: _formState.municipalityController,
                formKey: _formState.formKey,
                label: 'Municipio',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              buildTextField(
                controller: _formState.addressController,
                formKey: _formState.formKey,
                label: 'Dirección',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              buildTextField(
                controller: _formState.neighborhoodController,
                formKey: _formState.formKey,
                label: 'Barrio',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
              ),
              buildTextField(
                controller: _formState.phoneController,
                label: 'Número de Teléfono',
                formKey: _formState.formKey,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (value.length != 10) {
                    return 'Debe ser un número de 10 dígitos';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _formState.emergencyContactNameController,
                label: 'Contacto de Emergencia',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Este campo es obligatorio' : null,
                formKey: _formState.formKey,
              ),
              buildTextField(
                controller: _formState.emergencyContactPhoneController,
                formKey: _formState.formKey,
                label: 'Teléfono de Emergencia',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (value.length != 10) {
                    return 'Debe ser un número de 10 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _formState.isValidForm() ? onSave : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _formState.isValidForm() ? Colors.green : Colors.grey,
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _formState.selectedDate = picked;
        _formState.birthDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  UserModel _createUserModel() {
    return UserModel(
      name: _formState.nameController.text,
      lastName: _formState.lastNameController.text,
      document: _formState.documentController.text,
      birthDate: _formState.selectedDate!,
      age: int.parse(_formState.ageController.text),
      eps: _formState.selectedEPS!,
      bloodType: _formState.bloodTypeController.text,
      municipality: _formState.municipalityController.text,
      address: _formState.addressController.text,
      neighborhood: _formState.neighborhoodController.text,
      phone: _formState.phoneController.text,
      emergencyContactName: _formState.emergencyContactNameController.text,
      emergencyContactPhone: _formState.emergencyContactPhoneController.text,
      isOnboardingComplete: true,
    );
  }
}
