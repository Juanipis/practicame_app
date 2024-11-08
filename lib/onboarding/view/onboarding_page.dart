import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _documentController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _municipalityController = TextEditingController();
  final _addressController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();
  EPS? _selectedEPS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _documentController,
                decoration:
                    const InputDecoration(labelText: 'Número de Documento'),
              ),
              TextField(
                controller: _birthDateController,
                decoration:
                    const InputDecoration(labelText: 'Fecha de Nacimiento'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Edad'),
              ),
              DropdownButtonFormField<EPS>(
                value: _selectedEPS,
                decoration: const InputDecoration(labelText: 'EPS'),
                items: EPS.values.map((EPS eps) {
                  return DropdownMenuItem<EPS>(
                    value: eps,
                    child: Text(eps.name),
                  );
                }).toList(),
                onChanged: (EPS? newValue) {
                  setState(() {
                    _selectedEPS = newValue;
                  });
                },
              ),
              TextField(
                controller: _bloodTypeController,
                decoration: const InputDecoration(labelText: 'Tipo de Sangre'),
              ),
              TextField(
                controller: _municipalityController,
                decoration: const InputDecoration(labelText: 'Municipio'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(labelText: 'Barrio'),
              ),
              TextField(
                controller: _phoneController,
                decoration:
                    const InputDecoration(labelText: 'Número de Celular'),
              ),
              TextField(
                controller: _emergencyContactNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de Contacto de Emergencia',
                ),
              ),
              TextField(
                controller: _emergencyContactPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono de Contacto de Emergencia',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final userModel = UserModel(
                    name: _nameController.text,
                    lastName: _lastNameController.text,
                    document: _documentController.text,
                    birthDate: DateTime.parse(_birthDateController.text),
                    age: int.parse(_ageController.text),
                    eps: _selectedEPS ??
                        EPS.aliansalud_entidad_promotora_de_salud_s_a,
                    bloodType: _bloodTypeController.text,
                    municipality: _municipalityController.text,
                    address: _addressController.text,
                    neighborhood: _neighborhoodController.text,
                    phone: _phoneController.text,
                    emergencyContactName: _emergencyContactNameController.text,
                    emergencyContactPhone:
                        _emergencyContactPhoneController.text,
                    isOnboardingComplete: true,
                  );
                  context
                      .read<OnboardingCubit>()
                      .saveUserData(userModel: userModel);
                },
                child: const Text('Completar Onboarding'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
