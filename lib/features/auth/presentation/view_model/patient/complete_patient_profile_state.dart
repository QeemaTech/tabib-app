import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CompletePatientProfileState extends Equatable {
  final XFile? academicCertificateImage;
  final XFile? idProofImage;
  final XFile? medicalLicenseImage;
  final XFile? professionalPhoto;

  const CompletePatientProfileState({
    this.academicCertificateImage,
    this.idProofImage,
    this.medicalLicenseImage,
    this.professionalPhoto,
  });

  CompletePatientProfileState copyWith({
    XFile? academicCertificateImage,
    XFile? idProofImage,
    XFile? medicalLicenseImage,
    XFile? professionalPhoto,
  }) {
    return CompletePatientProfileState(
      academicCertificateImage:
          academicCertificateImage ?? this.academicCertificateImage,
      idProofImage: idProofImage ?? this.idProofImage,
      medicalLicenseImage: medicalLicenseImage ?? this.medicalLicenseImage,
      professionalPhoto: professionalPhoto ?? this.professionalPhoto,
    );
  }

  @override
  List<Object?> get props => [
    academicCertificateImage,
    idProofImage,
    medicalLicenseImage,
    professionalPhoto,
  ];
}
