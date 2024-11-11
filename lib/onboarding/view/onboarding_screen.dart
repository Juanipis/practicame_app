import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    required this.isTeacherMode,
    required this.onProfileCompleted,
    this.initialStudent,
    super.key,
  });

  final bool isTeacherMode;
  final void Function(UserModel) onProfileCompleted;
  final UserModel? initialStudent;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController municipalityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyContactNameController =
      TextEditingController();
  final TextEditingController emergencyContactPhoneController =
      TextEditingController();

  EPS? selectedEPS;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialStudent != null) {
      final student = widget.initialStudent!;
      nameController.text = student.name;
      lastNameController.text = student.lastName;
      documentController.text = student.document;
      birthDateController.text = student.birthDate.toString();
      ageController.text = student.age.toString();
      bloodTypeController.text = student.bloodType;
      municipalityController.text = student.municipality;
      addressController.text = student.address;
      neighborhoodController.text = student.neighborhood;
      phoneController.text = student.phone;
      emergencyContactNameController.text = student.emergencyContactName;
      emergencyContactPhoneController.text = student.emergencyContactPhone;
      selectedEPS = student.eps;
      selectedDate = student.birthDate;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    documentController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    bloodTypeController.dispose();
    municipalityController.dispose();
    addressController.dispose();
    neighborhoodController.dispose();
    phoneController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900), // Minimum date
      lastDate: DateTime.now(), // Maximum date
      helpText: 'Selecciona tu fecha de nacimiento',
      confirmText: 'Aceptar',
      cancelText: 'Cancelar',
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        birthDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  bool _isFormValid() {
    final isDateValid = selectedDate != null;
    final isEpsValid = selectedEPS != null;

    return (_formKey.currentState?.validate() ?? false) &&
        isDateValid &&
        isEpsValid;
  }

  void _submitForm() {
    if (!_isFormValid()) return;

    final user = UserModel(
      name: nameController.text,
      lastName: lastNameController.text,
      document: documentController.text,
      birthDate: selectedDate!,
      age: int.parse(ageController.text),
      eps: selectedEPS!,
      bloodType: bloodTypeController.text,
      municipality: municipalityController.text,
      address: addressController.text,
      neighborhood: neighborhoodController.text,
      phone: phoneController.text,
      emergencyContactName: emergencyContactNameController.text,
      emergencyContactPhone: emergencyContactPhoneController.text,
      isOnboardingComplete: true,
    );
    if (widget.initialStudent != null) {
      user.id = widget.initialStudent!.id;
    }

    widget.onProfileCompleted(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isTeacherMode ? 'Añadir estudiante' : 'Completa tu perfil',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  nameController,
                  'Nombre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el nombre';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  lastNameController,
                  'Apellido',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el apellido';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  documentController,
                  'Número de Documento',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el número de documento';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                _buildDateField(),
                _buildTextField(
                  ageController,
                  'Edad',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar la edad';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                _buildDropdownField(),
                _buildTextField(
                  bloodTypeController,
                  'Tipo de Sangre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el tipo de sangre';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  municipalityController,
                  'Municipio',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el municipio';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  addressController,
                  'Dirección',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar la dirección';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  neighborhoodController,
                  'Barrio',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el barrio';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  phoneController,
                  'Número de Celular',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el número de celular';
                    }
                    if (value.length != 10) {
                      return 'El número de celular debe tener 10 dígitos';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                  emergencyContactNameController,
                  'Nombre de Contacto de Emergencia',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el nombre de contacto de emergencia';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  emergencyContactPhoneController,
                  'Teléfono de Contacto de Emergencia',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Debes ingresar el teléfono de contacto de emergencia';
                    }
                    if (value.length != 10) {
                      return 'El teléfono de contacto de emergencia debe tener 10 dígitos';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isFormValid() ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isFormValid() ? Colors.green : Colors.grey,
                  ),
                  child: Text(
                    widget.isTeacherMode
                        ? 'Añadir Estudiante'
                        : 'Completar Perfil',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: validator,
        onChanged: (value) {
          setState(() {
            _formKey.currentState?.validate();
          });
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: birthDateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Fecha de Nacimiento',
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ),
        validator: (_) =>
            selectedDate == null ? 'Debes seleccionar una fecha' : null,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<EPS>(
        isExpanded: true,
        value: selectedEPS,
        decoration: const InputDecoration(labelText: 'EPS'),
        items: EPS.values.map((eps) {
          return DropdownMenuItem<EPS>(
            value: eps,
            child: Text(eps.name),
          );
        }).toList(),
        onChanged: (EPS? newValue) {
          setState(() {
            selectedEPS = newValue;
          });
        },
        validator: (value) =>
            value == null ? 'Debes seleccionar una EPS' : null,
      ),
    );
  }
}
