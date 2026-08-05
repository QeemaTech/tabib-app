import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_text_form_filed.dart';
import 'package:tabib_app/features/profile/domain/entities/patient_profile_entity.dart';
import 'package:tabib_app/features/profile/presentation/view_model/patient_profile_view_model.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_blood_type_selector.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_edit_actions_row.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_gender_selector.dart';
import 'package:tabib_app/features/profile/presentation/widgets/profile_labeled_field.dart';

class PatientPersonalInfoEditForm extends StatefulWidget {
  final PatientProfileEntity profile;
  final VoidCallback onCancel;

  const PatientPersonalInfoEditForm({
    super.key,
    required this.profile,
    required this.onCancel,
  });

  @override
  State<PatientPersonalInfoEditForm> createState() =>
      _PatientPersonalInfoEditFormState();
}

class _PatientPersonalInfoEditFormState
    extends State<PatientPersonalInfoEditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameArController;
  late final TextEditingController _fullNameEnController;
  late final TextEditingController _fullNameSoController;
  late final TextEditingController _allergiesController;
  late final TextEditingController _chronicConditionsController;
  late DateTime? _dateOfBirth;
  late String _gender;
  late String _bloodType;

  static const _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    _fullNameArController = TextEditingController(text: profile.fullNameAr);
    _fullNameEnController = TextEditingController(text: profile.fullNameEn);
    _fullNameSoController = TextEditingController(text: profile.fullNameSo);
    _allergiesController = TextEditingController(text: profile.allergies);
    _chronicConditionsController =
        TextEditingController(text: profile.chronicConditions);
    _dateOfBirth = DateTime.tryParse(profile.dateOfBirth);
    _gender = profile.gender.toUpperCase() == 'FEMALE' ? 'FEMALE' : 'MALE';
    _bloodType = profile.bloodType.isEmpty ? 'O+' : profile.bloodType;
  }

  @override
  void dispose() {
    _fullNameArController.dispose();
    _fullNameEnController.dispose();
    _fullNameSoController.dispose();
    _allergiesController.dispose();
    _chronicConditionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isUpdating = context.select<PatientProfileViewModel, bool>(
      (vm) => vm.state.updateProfileState.isLoading,
    );

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ProfileLabeledField(
            label: 'profile.personal.fullNameAr'.tr(),
            child: CustomTextFormField(
              controller: _fullNameArController,
              hintText: 'profile.personal.fullNameAr'.tr(),
              validator: _requiredValidator,
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.fullNameEn'.tr(),
            child: CustomTextFormField(
              controller: _fullNameEnController,
              hintText: 'profile.personal.fullNameEn'.tr(),
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.fullNameSo'.tr(),
            child: CustomTextFormField(
              controller: _fullNameSoController,
              hintText: 'profile.personal.fullNameSo'.tr(),
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.birthDate'.tr(),
            child: CustomTextFormField(
              readOnly: true,
              hintText: _dateOfBirth == null
                  ? 'profile.personal.chooseBirthDate'.tr()
                  : DateFormat('yyyy-MM-dd').format(_dateOfBirth!),
              style: theme.regular14.copyWith(color: theme.textColor600),
              onTap: _pickDate,
              suffixWidget: Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: theme.textColor300,
              ),
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.gender'.tr(),
            child: ProfileGenderSelector(
              selected: _gender,
              onChanged: (value) => setState(() => _gender = value),
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.bloodType'.tr(),
            child: ProfileBloodTypeSelector(
              selected: _bloodType,
              options: _bloodTypes,
              onChanged: (value) => setState(() => _bloodType = value),
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.allergies'.tr(),
            child: CustomTextFormField(
              controller: _allergiesController,
              hintText: 'profile.personal.allergies'.tr(),
              maxLines: 2,
            ),
          ),
          ProfileLabeledField(
            label: 'profile.personal.chronicConditions'.tr(),
            child: CustomTextFormField(
              controller: _chronicConditionsController,
              hintText: 'profile.personal.chronicConditions'.tr(),
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 12),
          ProfileEditActionsRow(
            isUpdating: isUpdating,
            onCancel: widget.onCancel,
            onSave: _submit,
          ),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.required'.tr();
    }
    return null;
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1998, 1, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null) setState(() => _dateOfBirth = selected);
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false) || _dateOfBirth == null) {
      return;
    }
    context.read<PatientProfileViewModel>().updateProfile(
          fullNameAr: _fullNameArController.text,
          fullNameEn: _fullNameEnController.text,
          fullNameSo: _fullNameSoController.text,
          dateOfBirth: DateFormat('yyyy-MM-dd').format(_dateOfBirth!),
          gender: _gender,
          bloodType: _bloodType,
          allergies: _allergiesController.text,
          chronicConditions: _chronicConditionsController.text,
        );
  }
}
