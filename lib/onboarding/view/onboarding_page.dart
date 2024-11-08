import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

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

  DateTime? _selectedDate;

  @override
  void dispose() {
    // Libera los controladores
    _nameController.dispose();
    _lastNameController.dispose();
    _documentController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _bloodTypeController.dispose();
    _municipalityController.dispose();
    _addressController.dispose();
    _neighborhoodController.dispose();
    _phoneController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ), // Por defecto, hace 18 años
      firstDate: DateTime(1900), // Fecha mínima
      lastDate: DateTime.now(), // Fecha máxima
      helpText: 'Selecciona tu fecha de nacimiento',
      confirmText: 'Aceptar',
      cancelText: 'Cancelar',
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        _formKey.currentState
            ?.validate(); // Forzar validación y actualizar estado
      });
    }
  }

  bool _isFormValid() {
    // Validar manualmente que la fecha y EPS no sean nulas
    final isDateValid = _selectedDate != null;
    final isEpsValid = _selectedEPS != null;

    return (_formKey.currentState?.validate() ?? false) &&
        isDateValid &&
        isEpsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Practícame\n¡Completa tu perfil!'),
        leading: Image.asset('assets/brand/logo.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Nombre',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _lastNameController,
                  label: 'Apellido',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _documentController,
                  label: 'Número de Documento',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo números
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                _buildDateField(
                  controller: _birthDateController,
                  label: 'Fecha de Nacimiento',
                  context: context,
                ),
                _buildTextField(
                  controller: _ageController,
                  label: 'Edad',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo números
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<EPS>(
                  isExpanded: true,
                  value: _selectedEPS,
                  decoration: const InputDecoration(labelText: 'EPS'),
                  items: EPS.values.map((eps) {
                    return DropdownMenuItem<EPS>(
                      value: eps,
                      child: Text(eps.name),
                    );
                  }).toList(),
                  onChanged: (EPS? newValue) {
                    setState(() {
                      _selectedEPS = newValue;
                      _formKey.currentState
                          ?.validate(); // Forzar validación y actualizar estado
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Debes seleccionar una EPS' : null,
                ),
                _buildTextField(
                  controller: _bloodTypeController,
                  label: 'Tipo de Sangre',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _municipalityController,
                  label: 'Municipio',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _addressController,
                  label: 'Dirección',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _neighborhoodController,
                  label: 'Barrio',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Número de Celular',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo números
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
                _buildTextField(
                  controller: _emergencyContactNameController,
                  label: 'Nombre de Contacto de Emergencia',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Este campo es obligatorio'
                      : null,
                ),
                _buildTextField(
                  controller: _emergencyContactPhoneController,
                  label: 'Teléfono de Contacto de Emergencia',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo números
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isFormValid()
                      ? () {
                          final userModel = UserModel(
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            document: _documentController.text,
                            birthDate: _selectedDate!,
                            age: int.parse(_ageController.text),
                            eps: _selectedEPS!,
                            bloodType: _bloodTypeController.text,
                            municipality: _municipalityController.text,
                            address: _addressController.text,
                            neighborhood: _neighborhoodController.text,
                            phone: _phoneController.text,
                            emergencyContactName:
                                _emergencyContactNameController.text,
                            emergencyContactPhone:
                                _emergencyContactPhoneController.text,
                            isOnboardingComplete: true,
                          );
                          context
                              .read<OnboardingCubit>()
                              .saveUserData(userModel: userModel);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isFormValid() ? Colors.green : Colors.grey,
                  ),
                  child: const Text('Completar Onboarding'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
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
          setState(() {
            _formKey.currentState
                ?.validate(); // Forzar validación y actualizar estado
          });
        },
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
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
        onTap: () => _selectDate(context),
        validator: (value) =>
            value?.isEmpty ?? true ? 'Debes seleccionar una fecha' : null,
      ),
    );
  }
}
