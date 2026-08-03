import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_services/image_picker_services.dart';
part 'complete_doc_profile_state.dart';

@injectable
class CompleteDocProfileCubit extends Cubit<CompleteDocProfileState> {
  CompleteDocProfileCubit(this._imagePickerServices)
    : super(const CompleteDocProfileState());
  final ImagePickerServices _imagePickerServices;
  void updateAcademicCertificateImage() async{
    final academicCertificateImage= await _imagePickerServices.pickImage();
    emit(state.copyWith(academicCertificateImage: academicCertificateImage));
  }

  void updateIdProofImage() async{
    final idProofImage= await _imagePickerServices.pickImage();
    emit(state.copyWith(idProofImage: idProofImage));
  }

  void updateMedicalLicenseImage()async {
    final medicalLicenseImage= await _imagePickerServices.pickImage();
    emit(state.copyWith(medicalLicenseImage: medicalLicenseImage));
  }

  void updateProfessionalPhoto() async{
    final professionalPhoto= await _imagePickerServices.pickImage();
    emit(state.copyWith(professionalPhoto: professionalPhoto));
  }
}
