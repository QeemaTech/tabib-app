import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_services/image_picker_services.dart';
import 'complete_patient_profile_state.dart';

@injectable
class CompletePatientProfileViewModel
    extends Cubit<CompletePatientProfileState> {
  final ImagePickerServices imagePickerServices;

  CompletePatientProfileViewModel(this.imagePickerServices)
      : super(const CompletePatientProfileState());

  void updateAcademicCertificateImage() async {
    final academicCertificateImage = await imagePickerServices.pickImage();
    emit(state.copyWith(academicCertificateImage: academicCertificateImage));
  }

  void updateIdProofImage() async {
    final idProofImage = await imagePickerServices.pickImage();
    emit(state.copyWith(idProofImage: idProofImage));
  }

  void updateMedicalLicenseImage() async {
    final medicalLicenseImage = await imagePickerServices.pickImage();
    emit(state.copyWith(medicalLicenseImage: medicalLicenseImage));
  }

  void updateProfessionalPhoto() async {
    final professionalPhoto = await imagePickerServices.pickImage();
    emit(state.copyWith(professionalPhoto: professionalPhoto));
  }
}
