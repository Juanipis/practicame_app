import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingFormState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
