import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/data_source/doctor_onboarding_data_source.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/submit_doctor_professional_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/specialties_response.dart';

@LazySingleton(as: DoctorOnboardingDataSource)
class DoctorOnboardingDataSourceImpl implements DoctorOnboardingDataSource {
  final ApiClient apiClient;

  DoctorOnboardingDataSourceImpl(this.apiClient);

  @override
  Future<Result<DoctorSpecialtiesResponse>> getSpecialties({String? parentId}) {
    return executeApi(() => apiClient.getDoctorSpecialties(parentId: parentId));
  }

  @override
  Future<Result<ProfessionalTitlesResponse>> getProfessionalTitles() {
    return executeApi(() => apiClient.getProfessionalTitles());
  }

  @override
  Future<Result<DoctorProfessionalResponse>> submitProfessional(
    SubmitDoctorProfessionalRequest request,
  ) {
    return executeApi(() => apiClient.submitDoctorProfessional(request));
  }

  @override
  Future<Result<DoctorDocumentsResponse>> submitDocuments({
    required String educationalCertificatePath,
    required String identityProofPath,
    required String medicalLicensePath,
    required String profilePicturePath,
  }) {
    return executeApi(() async {
      final educationalCertificate =
          await MultipartFile.fromFile(educationalCertificatePath);
      final identityProof = await MultipartFile.fromFile(identityProofPath);
      final medicalLicense = await MultipartFile.fromFile(medicalLicensePath);
      final profilePicture = await MultipartFile.fromFile(profilePicturePath);

      return apiClient.submitDoctorDocuments(
        educationalCertificate: educationalCertificate,
        identityProof: identityProof,
        medicalLicense: medicalLicense,
        profilePicture: profilePicture,
      );
    });
  }
}
