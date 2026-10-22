import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/data_source/doctor_onboarding_data_source.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/mapper/doctor_onboarding_mapper.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/submit_doctor_professional_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/entities/doctor_documents_entity.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/entities/doctor_professional_entity.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/entities/professional_title_entity.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/entities/specialty_entity.dart';
import 'package:tabib_app/features/doctor_flow/auth/domain/repo/doctor_onboarding_repo.dart';

@LazySingleton(as: DoctorOnboardingRepo)
class DoctorOnboardingRepoImpl implements DoctorOnboardingRepo {
  final DoctorOnboardingDataSource dataSource;

  DoctorOnboardingRepoImpl(this.dataSource);

  @override
  Future<Result<List<SpecialtyEntity>>> getSpecialties({
    String? parentId,
  }) async {
    final response = await dataSource.getSpecialties(parentId: parentId);
    switch (response) {
      case Success<DoctorSpecialtiesResponse>():
        return Success(response.data.toEntityList());
      case Failure<DoctorSpecialtiesResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<List<ProfessionalTitleEntity>>> getProfessionalTitles() async {
    final response = await dataSource.getProfessionalTitles();
    switch (response) {
      case Success<ProfessionalTitlesResponse>():
        return Success(response.data.toEntityList());
      case Failure<ProfessionalTitlesResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorProfessionalEntity>> submitProfessional({
    required String mainSpecialtyId,
    required List<String> subSpecialtyIds,
    required num consultationFee,
    required int durationChat,
    required int durationVoice,
    required int durationVideo,
    required int experienceYears,
    required String professionalTitle,
  }) async {
    final response = await dataSource.submitProfessional(
      SubmitDoctorProfessionalRequest(
        mainSpecialtyId: mainSpecialtyId,
        subSpecialtyIds: subSpecialtyIds,
        consultationFee: consultationFee,
        durationChat: durationChat,
        durationVoice: durationVoice,
        durationVideo: durationVideo,
        experienceYears: experienceYears,
        professionalTitle: professionalTitle,
      ),
    );
    switch (response) {
      case Success<DoctorProfessionalResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorProfessionalResponse>():
        return Failure(response.errorMessage);
    }
  }

  @override
  Future<Result<DoctorDocumentsEntity>> submitDocuments({
    required String educationalCertificatePath,
    required String identityProofPath,
    required String medicalLicensePath,
    required String profilePicturePath,
  }) async {
    final response = await dataSource.submitDocuments(
      educationalCertificatePath: educationalCertificatePath,
      identityProofPath: identityProofPath,
      medicalLicensePath: medicalLicensePath,
      profilePicturePath: profilePicturePath,
    );
    switch (response) {
      case Success<DoctorDocumentsResponse>():
        return Success(response.data.toEntity());
      case Failure<DoctorDocumentsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
