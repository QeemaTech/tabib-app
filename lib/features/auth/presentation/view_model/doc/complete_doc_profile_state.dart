import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_documents_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_professional_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/professional_title_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';

class CompleteDocProfileState extends Equatable {
  final XFile? academicCertificateImage;
  final XFile? idProofImage;
  final XFile? medicalLicenseImage;
  final XFile? professionalPhoto;

  final BaseState<List<SpecialtyEntity>> mainSpecialtiesState;
  final BaseState<List<SpecialtyEntity>> subSpecialtiesState;
  final BaseState<List<ProfessionalTitleEntity>> professionalTitlesState;
  final BaseState<DoctorProfessionalEntity> submitProfessionalState;
  final BaseState<DoctorDocumentsEntity> submitDocumentsState;

  final String? mainSpecialtyId;
  final List<String> subSpecialtyIds;
  final String? professionalTitle;
  final int? experienceYears;
  final String consultationFee;
  final String durationChat;
  final String durationVoice;
  final String durationVideo;

  const CompleteDocProfileState({
    this.academicCertificateImage,
    this.idProofImage,
    this.medicalLicenseImage,
    this.professionalPhoto,
    this.mainSpecialtiesState =
        const BaseState(requestState: RequestState.init),
    this.subSpecialtiesState =
        const BaseState(requestState: RequestState.init),
    this.professionalTitlesState =
        const BaseState(requestState: RequestState.init),
    this.submitProfessionalState =
        const BaseState(requestState: RequestState.init),
    this.submitDocumentsState =
        const BaseState(requestState: RequestState.init),
    this.mainSpecialtyId,
    this.subSpecialtyIds = const [],
    this.professionalTitle,
    this.experienceYears,
    this.consultationFee = '',
    this.durationChat = '',
    this.durationVoice = '',
    this.durationVideo = '',
  });

  CompleteDocProfileState copyWith({
    XFile? academicCertificateImage,
    XFile? idProofImage,
    XFile? medicalLicenseImage,
    XFile? professionalPhoto,
    BaseState<List<SpecialtyEntity>>? mainSpecialtiesState,
    BaseState<List<SpecialtyEntity>>? subSpecialtiesState,
    BaseState<List<ProfessionalTitleEntity>>? professionalTitlesState,
    BaseState<DoctorProfessionalEntity>? submitProfessionalState,
    BaseState<DoctorDocumentsEntity>? submitDocumentsState,
    String? mainSpecialtyId,
    bool clearMainSpecialty = false,
    List<String>? subSpecialtyIds,
    String? professionalTitle,
    bool clearProfessionalTitle = false,
    int? experienceYears,
    bool clearExperienceYears = false,
    String? consultationFee,
    String? durationChat,
    String? durationVoice,
    String? durationVideo,
  }) {
    return CompleteDocProfileState(
      academicCertificateImage:
          academicCertificateImage ?? this.academicCertificateImage,
      idProofImage: idProofImage ?? this.idProofImage,
      medicalLicenseImage: medicalLicenseImage ?? this.medicalLicenseImage,
      professionalPhoto: professionalPhoto ?? this.professionalPhoto,
      mainSpecialtiesState: mainSpecialtiesState ?? this.mainSpecialtiesState,
      subSpecialtiesState: subSpecialtiesState ?? this.subSpecialtiesState,
      professionalTitlesState:
          professionalTitlesState ?? this.professionalTitlesState,
      submitProfessionalState:
          submitProfessionalState ?? this.submitProfessionalState,
      submitDocumentsState: submitDocumentsState ?? this.submitDocumentsState,
      mainSpecialtyId:
          clearMainSpecialty ? null : (mainSpecialtyId ?? this.mainSpecialtyId),
      subSpecialtyIds: subSpecialtyIds ?? this.subSpecialtyIds,
      professionalTitle: clearProfessionalTitle
          ? null
          : (professionalTitle ?? this.professionalTitle),
      experienceYears: clearExperienceYears
          ? null
          : (experienceYears ?? this.experienceYears),
      consultationFee: consultationFee ?? this.consultationFee,
      durationChat: durationChat ?? this.durationChat,
      durationVoice: durationVoice ?? this.durationVoice,
      durationVideo: durationVideo ?? this.durationVideo,
    );
  }

  @override
  List<Object?> get props => [
        academicCertificateImage,
        idProofImage,
        medicalLicenseImage,
        professionalPhoto,
        mainSpecialtiesState,
        subSpecialtiesState,
        professionalTitlesState,
        submitProfessionalState,
        submitDocumentsState,
        mainSpecialtyId,
        subSpecialtyIds,
        professionalTitle,
        experienceYears,
        consultationFee,
        durationChat,
        durationVoice,
        durationVideo,
      ];
}
