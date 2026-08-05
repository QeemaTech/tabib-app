import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_documents_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/doctor_professional_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/professional_title_entity.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';

abstract interface class DoctorOnboardingRepo {
  Future<Result<List<SpecialtyEntity>>> getSpecialties({String? parentId});

  Future<Result<List<ProfessionalTitleEntity>>> getProfessionalTitles();

  Future<Result<DoctorProfessionalEntity>> submitProfessional({
    required String mainSpecialtyId,
    required List<String> subSpecialtyIds,
    required num consultationFee,
    required int durationChat,
    required int durationVoice,
    required int durationVideo,
    required int experienceYears,
    required String professionalTitle,
  });

  Future<Result<DoctorDocumentsEntity>> submitDocuments({
    required String educationalCertificatePath,
    required String identityProofPath,
    required String medicalLicensePath,
    required String profilePicturePath,
  });
}
