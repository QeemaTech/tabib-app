import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/auth/data/models/request/submit_doctor_professional_request.dart';
import 'package:tabib_app/features/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/auth/data/models/response/specialties_response.dart';

abstract interface class DoctorOnboardingDataSource {
  Future<Result<SpecialtiesResponse>> getSpecialties({String? parentId});

  Future<Result<ProfessionalTitlesResponse>> getProfessionalTitles();

  Future<Result<DoctorProfessionalResponse>> submitProfessional(
    SubmitDoctorProfessionalRequest request,
  );

  Future<Result<DoctorDocumentsResponse>> submitDocuments({
    required String educationalCertificatePath,
    required String identityProofPath,
    required String medicalLicensePath,
    required String profilePicturePath,
  });
}
