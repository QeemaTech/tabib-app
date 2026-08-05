import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/image_picker_services.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_documents_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_professional_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/professional_title_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:tabib_app/features/auth/domain/repo/doctor_onboarding_repo.dart';
import 'package:tabib_app/features/auth/presentation/view_model/doc/complete_doc_profile_state.dart';

@injectable
class CompleteDocProfileCubit extends Cubit<CompleteDocProfileState> {
  CompleteDocProfileCubit(
    this._imagePickerServices,
    this._doctorOnboardingRepo,
  ) : super(const CompleteDocProfileState());

  final ImagePickerServices _imagePickerServices;
  final DoctorOnboardingRepo _doctorOnboardingRepo;

  Future<void> initStepOne() async {
    emit(
      state.copyWith(
        mainSpecialtiesState: BaseState.loading(),
        professionalTitlesState: BaseState.loading(),
      ),
    );

    final specialtiesFuture = _doctorOnboardingRepo.getSpecialties();
    final titlesFuture = _doctorOnboardingRepo.getProfessionalTitles();
    final specialtiesResult = await specialtiesFuture;
    final titlesResult = await titlesFuture;

    switch (specialtiesResult) {
      case Success<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            mainSpecialtiesState: BaseState.loaded(specialtiesResult.data),
          ),
        );
      case Failure<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            mainSpecialtiesState:
                BaseState.error(specialtiesResult.errorMessage),
          ),
        );
    }

    switch (titlesResult) {
      case Success<List<ProfessionalTitleEntity>>():
        emit(
          state.copyWith(
            professionalTitlesState: BaseState.loaded(titlesResult.data),
          ),
        );
      case Failure<List<ProfessionalTitleEntity>>():
        emit(
          state.copyWith(
            professionalTitlesState: BaseState.error(titlesResult.errorMessage),
          ),
        );
    }
  }

  Future<void> selectMainSpecialty(String id) async {
    emit(
      state.copyWith(
        mainSpecialtyId: id,
        subSpecialtyIds: const [],
        subSpecialtiesState: BaseState.loading(),
      ),
    );

    final result = await _doctorOnboardingRepo.getSpecialties(parentId: id);
    switch (result) {
      case Success<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            subSpecialtiesState: BaseState.loaded(result.data),
          ),
        );
      case Failure<List<SpecialtyEntity>>():
        emit(
          state.copyWith(
            subSpecialtiesState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  void toggleSubSpecialty(String id) {
    final current = List<String>.from(state.subSpecialtyIds);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    emit(state.copyWith(subSpecialtyIds: current));
  }

  void selectProfessionalTitle(String value) {
    emit(state.copyWith(professionalTitle: value));
  }

  void selectExperienceYears(int years) {
    emit(state.copyWith(experienceYears: years));
  }

  void updateConsultationFee(String value) {
    emit(state.copyWith(consultationFee: value));
  }

  void updateDurationChat(String value) {
    emit(state.copyWith(durationChat: value));
  }

  void updateDurationVoice(String value) {
    emit(state.copyWith(durationVoice: value));
  }

  void updateDurationVideo(String value) {
    emit(state.copyWith(durationVideo: value));
  }

  Future<void> submitProfessional() async {
    final mainSpecialtyId = state.mainSpecialtyId;
    final professionalTitle = state.professionalTitle;
    final experienceYears = state.experienceYears;
    final consultationFee = num.tryParse(state.consultationFee.trim());
    final durationChat = int.tryParse(state.durationChat.trim());
    final durationVoice = int.tryParse(state.durationVoice.trim());
    final durationVideo = int.tryParse(state.durationVideo.trim());
    final subSpecialties = state.subSpecialtiesState.data ?? const [];

    final needsSubSpecialty = subSpecialties.isNotEmpty;
    final missingRequired = mainSpecialtyId == null ||
        mainSpecialtyId.isEmpty ||
        professionalTitle == null ||
        professionalTitle.isEmpty ||
        experienceYears == null ||
        consultationFee == null ||
        consultationFee <= 0 ||
        durationChat == null ||
        durationChat <= 0 ||
        durationVoice == null ||
        durationVoice <= 0 ||
        durationVideo == null ||
        durationVideo <= 0 ||
        (needsSubSpecialty && state.subSpecialtyIds.isEmpty);

    if (missingRequired) {
      emit(
        state.copyWith(
          submitProfessionalState: BaseState.error(
            'auth.completeProfile.validation.fillRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(submitProfessionalState: BaseState.loading()));

    final result = await _doctorOnboardingRepo.submitProfessional(
      mainSpecialtyId: mainSpecialtyId,
      subSpecialtyIds: state.subSpecialtyIds,
      consultationFee: consultationFee,
      durationChat: durationChat,
      durationVoice: durationVoice,
      durationVideo: durationVideo,
      experienceYears: experienceYears,
      professionalTitle: professionalTitle,
    );

    switch (result) {
      case Success<DoctorProfessionalEntity>():
        emit(
          state.copyWith(
            submitProfessionalState: BaseState.loaded(result.data),
          ),
        );
      case Failure<DoctorProfessionalEntity>():
        emit(
          state.copyWith(
            submitProfessionalState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  Future<void> updateAcademicCertificateImage() async {
    final academicCertificateImage = await _imagePickerServices.pickImage();
    emit(state.copyWith(academicCertificateImage: academicCertificateImage));
  }

  Future<void> updateIdProofImage() async {
    final idProofImage = await _imagePickerServices.pickImage();
    emit(state.copyWith(idProofImage: idProofImage));
  }

  Future<void> updateMedicalLicenseImage() async {
    final medicalLicenseImage = await _imagePickerServices.pickImage();
    emit(state.copyWith(medicalLicenseImage: medicalLicenseImage));
  }

  Future<void> updateProfessionalPhoto() async {
    final professionalPhoto = await _imagePickerServices.pickImage();
    emit(state.copyWith(professionalPhoto: professionalPhoto));
  }

  Future<void> submitDocuments() async {
    final educationalCertificate = state.academicCertificateImage;
    final identityProof = state.idProofImage;
    final medicalLicense = state.medicalLicenseImage;
    final profilePicture = state.professionalPhoto;

    if (educationalCertificate == null ||
        identityProof == null ||
        medicalLicense == null ||
        profilePicture == null) {
      emit(
        state.copyWith(
          submitDocumentsState: BaseState.error(
            'auth.completeProfile.validation.fillRequired'.tr(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(submitDocumentsState: BaseState.loading()));

    final result = await _doctorOnboardingRepo.submitDocuments(
      educationalCertificatePath: educationalCertificate.path,
      identityProofPath: identityProof.path,
      medicalLicensePath: medicalLicense.path,
      profilePicturePath: profilePicture.path,
    );

    switch (result) {
      case Success<DoctorDocumentsEntity>():
        emit(
          state.copyWith(
            submitDocumentsState: BaseState.loaded(result.data),
          ),
        );
      case Failure<DoctorDocumentsEntity>():
        emit(
          state.copyWith(
            submitDocumentsState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
