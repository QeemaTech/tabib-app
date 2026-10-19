import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tabib_app/core/api/api_constant.dart';
import 'package:tabib_app/features/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/auth/data/models/request/submit_doctor_professional_request.dart';
import 'package:tabib_app/features/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/create_payment_request.dart';
import 'package:tabib_app/features/appointments/data/models/request/validate_coupon_request.dart';
import 'package:tabib_app/features/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/create_payment_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointment_details_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_invoice_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/validate_coupon_response.dart';
import 'package:tabib_app/features/home/data/models/request/book_appointment_request.dart';
import 'package:tabib_app/features/home/data/models/response/book_appointment_response.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_availability_response.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_dashboard_response.dart';
import 'package:tabib_app/features/home/data/models/response/doctor_details_response.dart';
import 'package:tabib_app/features/home/data/models/response/patient_home_response.dart';
import 'package:tabib_app/features/home/data/models/response/search_doctors_response.dart';
import 'package:tabib_app/features/patients/data/models/response/doctor_patients_response.dart';
import 'package:tabib_app/features/patients/data/models/response/patient_file_response.dart';
import 'package:tabib_app/features/profile/data/models/request/update_patient_profile_request.dart';
import 'package:tabib_app/features/profile/data/models/response/doctor_profile_response.dart';
import 'package:tabib_app/features/profile/data/models/response/patient_profile_response.dart';
import 'package:tabib_app/features/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/reservations/data/models/request/reject_appointment_request.dart';
import 'package:tabib_app/features/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/reservations/data/models/response/doctor_appointments_response.dart';
import 'package:tabib_app/features/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/schedule/data/models/response/schedule_preview_response.dart';
import 'package:tabib_app/features/wallet/data/models/request/create_withdrawal_request.dart';
import 'package:tabib_app/features/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/wallet/data/models/response/wallet_withdrawals_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoint.registerPatient)
  Future<RegisterResponse> registerPatient(@Body() RegisterRequest request);

  @POST(EndPoint.registerDoctor)
  Future<RegisterResponse> registerDoctor(@Body() RegisterRequest request);

  @POST(EndPoint.sendOtp)
  Future<RegisterResponse> sendOtp(@Body() LoginRequest request);

  @POST(EndPoint.verifyOtp)
  Future<VerifyOtpResponse> verifyOtp(@Body() VerifyOtpRequest request);

  @MultiPart()
  @PUT(EndPoint.patientHealthProfile)
  Future<PatientHealthProfileResponse> updatePatientHealthProfile({
    @Part(name: 'dateOfBirth') required String dateOfBirth,
    @Part(name: 'gender') required String gender,
    @Part(name: 'heightCm') required int heightCm,
    @Part(name: 'weightKg') required int weightKg,
    @Part(name: 'files') required List<MultipartFile> files,
  });

  @MultiPart()
  @PUT(EndPoint.patientMedicalInfo)
  Future<PatientMedicalInfoResponse> updatePatientMedicalInfo({
    @Part(name: 'chronicConditions') required String chronicConditions,
    @Part(name: 'currentMedications') required String currentMedications,
    @Part(name: 'hasMedicationAllergy') required bool hasMedicationAllergy,
    @Part(name: 'allergyDetails') required String allergyDetails,
    @Part(name: 'files') required List<MultipartFile> files,
  });

  @GET(EndPoint.patientHome)
  Future<PatientHomeResponse> getPatientHome();

  @GET(EndPoint.patientDoctors)
  Future<SearchDoctorsResponse> searchDoctors({
    @Query('search') String? search,
    @Query('specialty') String? specialty,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET(EndPoint.patientDoctorDetails)
  Future<DoctorDetailsResponse> getPatientDoctorDetails(@Path('id') String id);

  @GET(EndPoint.patientDoctorAvailability)
  Future<DoctorAvailabilityResponse> getPatientDoctorAvailability({
    @Path('id') required String id,
    @Query('date') required String date,
  });

  @POST(EndPoint.patientAppointments)
  Future<BookAppointmentResponse> bookAppointment(
    @Body() BookAppointmentRequest request,
  );

  @GET(EndPoint.patientAppointments)
  Future<PatientAppointmentsResponse> getPatientAppointments();

  @GET(EndPoint.patientAppointmentDetails)
  Future<PatientAppointmentDetailsResponse> getPatientAppointmentDetails(
    @Path('id') String id,
  );

  @PATCH(EndPoint.patientCancelAppointment)
  Future<CancelAppointmentResponse> cancelAppointment(
    @Path('id') String id,
    @Body() CancelAppointmentRequest request,
  );

  @POST(EndPoint.patientValidateCoupon)
  Future<ValidateCouponResponse> validateCoupon(
    @Body() ValidateCouponRequest request,
  );

  @POST(EndPoint.patientPayments)
  Future<CreatePaymentResponse> createPayment(
    @Body() CreatePaymentRequest request,
  );

  @GET(EndPoint.patientInvoice)
  Future<PatientInvoiceResponse> getPatientInvoice(@Path('id') String id);

  @GET(EndPoint.patientWallet)
  Future<WalletResponse> getPatientWallet();

  @GET(EndPoint.doctorWallet)
  Future<DoctorWalletResponse> getDoctorWallet();

  @GET(EndPoint.doctorWalletTransactions)
  Future<WalletTransactionsResponse> getDoctorWalletTransactions({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET(EndPoint.doctorWalletWithdrawals)
  Future<WalletWithdrawalsResponse> getDoctorWalletWithdrawals({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET(EndPoint.doctorWalletWithdrawalById)
  Future<WalletWithdrawalDetailsResponse> getDoctorWalletWithdrawalById(
    @Path('id') String id,
  );

  @POST(EndPoint.doctorWalletWithdrawals)
  Future<CreateWithdrawalResponse> createDoctorWalletWithdrawal(
    @Header('Idempotency-Key') String idempotencyKey,
    @Body() CreateWithdrawalRequest request,
  );

  @DELETE(EndPoint.doctorWalletWithdrawalById)
  Future<CreateWithdrawalResponse> cancelDoctorWalletWithdrawal(
    @Path('id') String id,
  );

  @GET(EndPoint.doctorDashboard)
  Future<DoctorDashboardResponse> getDoctorDashboard();

  @GET(EndPoint.doctorPatients)
  Future<DoctorPatientsResponse> getDoctorPatients({
    @Query('search') String? search,
    @Query('filter') String? filter,
  });

  @GET(EndPoint.doctorAppointments)
  Future<DoctorAppointmentsResponse> getDoctorAppointments({
    @Query('status') String? status,
    @Query('date') String? date,
  });

  @GET(EndPoint.doctorAppointmentDetails)
  Future<DoctorAppointmentDetailsResponse> getDoctorAppointmentDetails(
    @Path('id') String id,
  );

  @POST(EndPoint.doctorAppointmentReport)
  Future<CreateDoctorReportResponse> createDoctorAppointmentReport(
    @Path('id') String id,
    @Body() CreateDoctorReportRequest request,
  );

  @GET(EndPoint.doctorAppointmentPatientFile)
  Future<PatientFileResponse> getDoctorAppointmentPatientFile(
    @Path('id') String id,
  );

  @PATCH(EndPoint.doctorAppointmentAccept)
  Future<DoctorAppointmentDetailsResponse> acceptDoctorAppointment(
    @Path('id') String id,
  );

  @PATCH(EndPoint.doctorAppointmentReject)
  Future<DoctorAppointmentDetailsResponse> rejectDoctorAppointment(
    @Path('id') String id,
    @Body() RejectAppointmentRequest request,
  );

  @GET(EndPoint.doctorSchedule)
  Future<DoctorScheduleResponse> getDoctorSchedule();

  @PUT(EndPoint.doctorSchedule)
  Future<DoctorScheduleResponse> replaceDoctorSchedule(
    @Body() ReplaceWeekScheduleRequest request,
  );

  @GET(EndPoint.doctorSchedulePreview)
  Future<SchedulePreviewResponse> getDoctorSchedulePreview({
    @Query('date') required String date,
  });

  @PATCH(EndPoint.doctorScheduleDay)
  Future<DoctorScheduleResponse> updateDoctorScheduleDay(
    @Path('dayOfWeek') int dayOfWeek,
    @Body() UpdateDayScheduleRequest request,
  );

  @DELETE(EndPoint.doctorScheduleDay)
  Future<DoctorScheduleResponse> deleteDoctorScheduleDay(
    @Path('dayOfWeek') int dayOfWeek,
  );

  @GET(EndPoint.patientProfile)
  Future<PatientProfileResponse> getPatientProfile();

  @PUT(EndPoint.patientProfile)
  Future<PatientProfileResponse> updatePatientProfile(
    @Body() UpdatePatientProfileRequest request,
  );

  @GET(EndPoint.doctorProfile)
  Future<DoctorProfileResponse> getDoctorProfile();

  @GET(EndPoint.specialties)
  Future<SpecialtiesResponse> getSpecialties({
    @Query('parentId') String? parentId,
  });

  @GET(EndPoint.doctorProfessionalTitles)
  Future<ProfessionalTitlesResponse> getProfessionalTitles();

  @PATCH(EndPoint.doctorOnboardingProfessional)
  Future<DoctorProfessionalResponse> submitDoctorProfessional(
    @Body() SubmitDoctorProfessionalRequest request,
  );

  @MultiPart()
  @POST(EndPoint.doctorOnboardingDocuments)
  Future<DoctorDocumentsResponse> submitDoctorDocuments({
    @Part(name: 'educationalCertificate')
    required MultipartFile educationalCertificate,
    @Part(name: 'identityProof') required MultipartFile identityProof,
    @Part(name: 'medicalLicense') required MultipartFile medicalLicense,
    @Part(name: 'profilePicture') required MultipartFile profilePicture,
  });
}
