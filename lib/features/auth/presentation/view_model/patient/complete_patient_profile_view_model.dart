import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/image_picker_services.dart';
import 'complete_patient_profile_state.dart';

@injectable
class CompletePatientProfileViewModel
    extends Cubit<CompletePatientProfileState> {

  CompletePatientProfileViewModel({required this.imagePicker})
      : super(const CompletePatientProfileState());

  final ImagePickerServices imagePicker ;
  Future<void> pickImages({required ImageSource source}) async {
    final images = await imagePicker.pickMultiImage(source: source);
    emit(state.copyWith(reports: images));
  }

  // void updateAcademicCertificateImage({
  //   required ImageSource source,
  // }) async {
  //   final academicCertificateImage = await imagePicker.pickImage(
  //     source: source,
  //   );
  //   emit(state.copyWith(academicCertificateImage: academicCertificateImage));
  // }

  // void updateIdProofImage({
  //   required ImageSource source,
  // }) async {
  //   final idProofImage = await imagePicker.pickImage(
  //     source: source,
  //   );
  //   emit(state.copyWith(idProofImage: idProofImage));
  // }

  // void updateMedicalLicenseImage({
  //   required ImageSource source,
  // }) async {
  //   final medicalLicenseImage = await imagePicker.pickImage(
  //     source: source,
  //   );
  //   emit(state.copyWith(medicalLicenseImage: medicalLicenseImage));
  // }

  // void updateProfessionalPhoto({
  //   required ImageSource source,
  // }) async {
  //   final professionalPhoto = await imagePicker.pickImage(
  //     source: source,
  //   );
  //   emit(state.copyWith(professionalPhoto: professionalPhoto));
  // }

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
  void updateReportesAndrays({required ImageSource source}) async {
    final reportesAndrays = await imagePicker.pickMultiImage(source: source);
    emit(state.copyWith(reportesAndrays: reportesAndrays));
  }

}
