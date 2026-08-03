import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_health_profile_result_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/patient_medical_info_result_entity.dart';

class CompletePatientProfileState extends Equatable {
  final XFile? academicCertificateImage;
  final XFile? idProofImage;
  final XFile? medicalLicenseImage;
  final XFile? professionalPhoto;
  final DateTime? dateOfBirth;
  final String? sex;
  final String? weight;
  final String? height;
  final List<XFile>? reports;
  final int currentStep;
  final String? chronicIllnesses;
  final String? essentialMedications;
  final bool? areHaveAnyAllergies;
  final String? allergyDetails;
  final List<XFile>? reportesAndrays;
  final BaseState<PatientHealthProfileResultEntity> healthProfileState;
  final BaseState<PatientMedicalInfoResultEntity> medicalInfoState;

  const CompletePatientProfileState({
    this.academicCertificateImage,
    this.idProofImage,
    this.medicalLicenseImage,
    this.professionalPhoto,
    this.dateOfBirth,
    this.sex,
    this.weight,
    this.height,
    this.reports,
    this.currentStep = 0,
    this.chronicIllnesses,
    this.essentialMedications,
    this.areHaveAnyAllergies = false,
    this.allergyDetails,
    this.reportesAndrays,
    this.healthProfileState = const BaseState(requestState: RequestState.init),
    this.medicalInfoState = const BaseState(requestState: RequestState.init),
  });

  CompletePatientProfileState copyWith({
    XFile? academicCertificateImage,
    XFile? idProofImage,
    XFile? medicalLicenseImage,
    XFile? professionalPhoto,
    DateTime? dateOfBirth,
    String? sex,
    String? weight,
    String? height,
    List<XFile>? reports,
    int? currentStep,
    String? chronicIllnesses,
    String? essentialMedications,
    bool? areHaveAnyAllergies,
    String? allergyDetails,
    List<XFile>? reportesAndrays,
    BaseState<PatientHealthProfileResultEntity>? healthProfileState,
    BaseState<PatientMedicalInfoResultEntity>? medicalInfoState,
  }) {
    return CompletePatientProfileState(
      academicCertificateImage:
          academicCertificateImage ?? this.academicCertificateImage,
      idProofImage: idProofImage ?? this.idProofImage,
      medicalLicenseImage: medicalLicenseImage ?? this.medicalLicenseImage,
      professionalPhoto: professionalPhoto ?? this.professionalPhoto,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      reports: reports ?? this.reports,
      currentStep: currentStep ?? this.currentStep,
      chronicIllnesses: chronicIllnesses ?? this.chronicIllnesses,
      essentialMedications: essentialMedications ?? this.essentialMedications,
      areHaveAnyAllergies: areHaveAnyAllergies ?? this.areHaveAnyAllergies,
      allergyDetails: allergyDetails ?? this.allergyDetails,
      reportesAndrays: reportesAndrays ?? this.reportesAndrays,
      healthProfileState: healthProfileState ?? this.healthProfileState,
      medicalInfoState: medicalInfoState ?? this.medicalInfoState,
    );
  }

  @override
  List<Object?> get props => [
    academicCertificateImage,
    idProofImage,
    medicalLicenseImage,
    professionalPhoto,
    dateOfBirth,
    sex,
    weight,
    height,
    reports,
    currentStep,
    chronicIllnesses,
    essentialMedications,
    areHaveAnyAllergies,
    allergyDetails,
    reportesAndrays,
    healthProfileState,
    medicalInfoState,
  ];
}
