import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/image_picker_services.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_health_profile_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_health_profile_result_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_medical_info_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/entities/patient_medical_info_result_entity.dart';
import 'package:tabib_app/features/patient_flow/auth/domain/repo/patient_health_profile_repo.dart';
import 'complete_patient_profile_state.dart';

@injectable
class CompletePatientProfileViewModel
    extends Cubit<CompletePatientProfileState> {
  CompletePatientProfileViewModel({
    required this.imagePicker,
    required this.patientHealthProfileRepo,
  }) : super(const CompletePatientProfileState());

  final ImagePickerServices imagePicker;
  final PatientHealthProfileRepo patientHealthProfileRepo;

  Future<void> pickImages({required ImageSource source}) async {
    final images = await imagePicker.pickMultiImage(source: source);
    emit(state.copyWith(reports: images));
  }

  void updateDateOfBirth(DateTime dateOfBirth) {
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  void updateSex(String? sex) {
    emit(state.copyWith(sex: sex));
  }

  void updateWeight(String? weight) {
    emit(state.copyWith(weight: weight));
  }

  void updateHeight(String? height) {
    emit(state.copyWith(height: height));
  }

  void updateCurrentStep(int currentStep) {
    emit(state.copyWith(currentStep: currentStep));
  }

  void updateChronicIllnesses(String? chronicIllnesses) {
    emit(state.copyWith(chronicIllnesses: chronicIllnesses));
  }

  void updateEssentialMedications(String? essentialMedications) {
    emit(state.copyWith(essentialMedications: essentialMedications));
  }

  void updateAreHaveAnyAllergies(bool? areHaveAnyAllergies) {
    emit(state.copyWith(areHaveAnyAllergies: areHaveAnyAllergies));
  }

  void updateAllergyDetails(String? allergyDetails) {
    emit(state.copyWith(allergyDetails: allergyDetails));
  }

  Future<void> pickMedicalInfoFiles({required ImageSource source}) async {
    final files = await imagePicker.pickMultiImage(source: source);
    emit(state.copyWith(reportesAndrays: files));
  }

  Future<void> submitHealthProfile() async {
    final dateOfBirth = state.dateOfBirth;
    final sex = state.sex;
    final weight = state.weight;
    final height = state.height;

    if (dateOfBirth == null ||
        sex == null ||
        weight == null ||
        height == null) {
      emit(
        state.copyWith(
          healthProfileState: BaseState.error(
            'auth.completePatientProfile.validation.fillRequired'.tr(),
          ),
        ),
      );
      return;
    }

    final gender = _mapGender(sex);
    final weightKg = _parseMeasurement(weight);
    final heightCm = _parseMeasurement(height);

    if (gender == null || weightKg == null || heightCm == null) {
      emit(
        state.copyWith(
          healthProfileState: BaseState.error(
            'auth.completePatientProfile.validation.fillRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(healthProfileState: BaseState.loading()));

    final entity = PatientHealthProfileEntity(
      dateOfBirth: DateFormat('yyyy-MM-dd').format(dateOfBirth),
      gender: gender,
      heightCm: heightCm,
      weightKg: weightKg,
      files: (state.reports ?? []).map((file) => file.path).toList(),
    );

    final result = await patientHealthProfileRepo.updateHealthProfile(entity);
    switch (result) {
      case Success<PatientHealthProfileResultEntity>():
        emit(
          state.copyWith(
            healthProfileState: BaseState.loaded(result.data),
          ),
        );
      case Failure<PatientHealthProfileResultEntity>():
        emit(
          state.copyWith(
            healthProfileState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> submitMedicalInfo() async {
    emit(state.copyWith(medicalInfoState: BaseState.loading()));

    final entity = PatientMedicalInfoEntity(
      chronicConditions: state.chronicIllnesses ?? '',
      currentMedications: state.essentialMedications ?? '',
      hasMedicationAllergy: state.areHaveAnyAllergies ?? false,
      allergyDetails: state.allergyDetails ?? '',
      files: (state.reportesAndrays ?? []).map((file) => file.path).toList(),
    );

    final result = await patientHealthProfileRepo.updateMedicalInfo(entity);
    switch (result) {
      case Success<PatientMedicalInfoResultEntity>():
        emit(
          state.copyWith(
            medicalInfoState: BaseState.loaded(result.data),
          ),
        );
      case Failure<PatientMedicalInfoResultEntity>():
        emit(
          state.copyWith(
            medicalInfoState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  String? _mapGender(String sex) {
    final male = 'auth.completePatientProfile.stepOne.male'.tr();
    final female = 'auth.completePatientProfile.stepOne.female'.tr();
    if (sex == male || sex.toLowerCase() == 'male') return 'MALE';
    if (sex == female || sex.toLowerCase() == 'female') return 'FEMALE';
    return null;
  }

  int? _parseMeasurement(String value) {
    final match = RegExp(r'\d+').firstMatch(value);
    if (match == null) return null;
    return int.tryParse(match.group(0)!);
  }
}
