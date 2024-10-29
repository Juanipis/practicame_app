import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final _nameController = TextEditingController();
  final _documentController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _epsController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _documentController,
                decoration: InputDecoration(labelText: 'Número de Documento'),
              ),
              TextField(
                controller: _birthDateController,
                decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Edad'),
              ),
              TextField(
                controller: _epsController,
                decoration: InputDecoration(labelText: 'EPS'),
              ),
              TextField(
                controller: _bloodTypeController,
                decoration: InputDecoration(labelText: 'Tipo de Sangre'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Municipio'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: _neighborhoodController,
                decoration: InputDecoration(labelText: 'Barrio'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Número de Celular'),
              ),
              TextField(
                controller: _emergencyContactNameController,
                decoration: InputDecoration(
                    labelText: 'Nombre de Contacto de Emergencia'),
              ),
              TextField(
                controller: _emergencyContactPhoneController,
                decoration: InputDecoration(
                    labelText: 'Teléfono de Contacto de Emergencia'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<OnboardingCubit>().saveUserData(
                        name: _nameController.text,
                        document: _documentController.text,
                        birthDate: _birthDateController.text,
                        age: int.parse(_ageController.text),
                        eps: _epsController.text,
                        bloodType: _bloodTypeController.text,
                        city: _cityController.text,
                        address: _addressController.text,
                        neighborhood: _neighborhoodController.text,
                        phone: _phoneController.text,
                        emergencyContactName:
                            _emergencyContactNameController.text,
                        emergencyContactPhone:
                            _emergencyContactPhoneController.text,
                      );
                },
                child: Text('Completar Onboarding'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
