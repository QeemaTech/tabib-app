import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tabib_app/core/api/api_constant.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/submit_doctor_professional_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_documents_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/doctor_professional_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_health_profile_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/patient_medical_info_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/professional_titles_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/doctor_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/login_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_device_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/register_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/request/verify_otp_request.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/register_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/unregister_device_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/specialties_response.dart';
import 'package:tabib_app/features/patient_flow/auth/data/models/response/verify_otp_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/request/cancel_appointment_request.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/request/create_payment_request.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/request/validate_coupon_request.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/cancel_appointment_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/create_payment_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_appointment_details_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_invoice_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_invoices_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/validate_coupon_response.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/request/book_appointment_request.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/book_appointment_response.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/doctor_availability_response.dart';
import 'package:tabib_app/features/doctor_flow/home/data/models/response/doctor_dashboard_response.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/doctor_details_response.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/patient_home_response.dart';
import 'package:tabib_app/features/patient_flow/home/data/models/response/search_doctors_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_prescriptions_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_record_detail_response.dart';
import 'package:tabib_app/features/patient_flow/records/data/models/response/patient_reports_response.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/doctor_patients_response.dart';
import 'package:tabib_app/features/doctor_flow/patients/data/models/response/patient_file_response.dart';
import 'package:tabib_app/features/patient_flow/profile/data/models/request/update_patient_profile_request.dart';
import 'package:tabib_app/features/doctor_flow/profile/data/models/response/doctor_profile_response.dart';
import 'package:tabib_app/features/patient_flow/profile/data/models/response/patient_profile_response.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/request/create_doctor_report_request.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/request/reject_appointment_request.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/response/create_doctor_report_response.dart';
import 'package:tabib_app/features/doctor_flow/reservations/data/models/response/doctor_appointments_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/replace_week_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/request/update_day_schedule_request.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/doctor_schedule_response.dart';
import 'package:tabib_app/features/doctor_flow/schedule/data/models/response/schedule_preview_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/request/create_withdrawal_request.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/doctor_wallet_response.dart';
import 'package:tabib_app/features/patient_flow/wallet/data/models/response/wallet_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_transactions_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawal_details_response.dart';
import 'package:tabib_app/features/doctor_flow/wallet/data/models/response/wallet_withdrawals_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/doctor_flow/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/mark_all_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notification_read_response.dart';
import 'package:tabib_app/features/patient_flow/notification/data/models/response/notifications_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/doctor_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/request/agora_token_request.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/agora_token_response.dart';
import 'package:tabib_app/features/patient_flow/calls/data/models/response/end_call_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/doctor_flow/chat/data/models/response/start_consultation_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/request/start_consultation_request.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/messages_response.dart';
import 'package:tabib_app/features/patient_flow/chat/data/models/response/start_consultation_response.dart';

part 'api_client.g.dart';


@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoint.registerPatient)
  Future<PatientRegisterResponse> registerPatient(
    @Body() PatientRegisterRequest request,
  );

  @POST(EndPoint.registerDoctor)
  Future<DoctorRegisterResponse> registerDoctor(
    @Body() DoctorRegisterRequest request,
  );

  @POST(EndPoint.sendOtp)
  Future<DoctorRegisterResponse> sendDoctorOtp(
    @Body() DoctorLoginRequest request,
  );

  @POST(EndPoint.sendOtp)
  Future<PatientRegisterResponse> sendPatientOtp(
    @Body() PatientLoginRequest request,
  );

  @POST(EndPoint.verifyOtp)
  Future<DoctorVerifyOtpResponse> verifyDoctorOtp(
    @Body() DoctorVerifyOtpRequest request,
  );

  @POST(EndPoint.verifyOtp)
  Future<PatientVerifyOtpResponse> verifyPatientOtp(
    @Body() PatientVerifyOtpRequest request,
  );

  @POST(EndPoint.registerDevice)
  Future<DoctorRegisterDeviceResponse> registerDoctorDevice(
    @Body() DoctorRegisterDeviceRequest request,
  );

  @POST(EndPoint.registerDevice)
  Future<PatientRegisterDeviceResponse> registerPatientDevice(
    @Body() PatientRegisterDeviceRequest request,
  );

  @DELETE(EndPoint.registerDevice)
  Future<DoctorUnregisterDeviceResponse> unregisterDoctorDevice(
    @Body() DoctorRegisterDeviceRequest request,
  );

  @DELETE(EndPoint.registerDevice)
  Future<PatientUnregisterDeviceResponse> unregisterPatientDevice(
    @Body() PatientRegisterDeviceRequest request,
  );

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

  @GET(EndPoint.patientAppointmentReport)
  Future<PatientRecordDetailResponse> getPatientAppointmentReport(
    @Path('id') String id,
  );

  @GET(EndPoint.patientAppointmentPrescription)
  Future<PatientRecordDetailResponse> getPatientAppointmentPrescription(
    @Path('id') String id,
  );

  @GET(EndPoint.patientReports)
  Future<PatientReportsResponse> getPatientReports({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @GET(EndPoint.patientReportDetails)
  Future<PatientRecordDetailResponse> getPatientReportDetails(
    @Path('id') String id,
  );

  @GET(EndPoint.patientPrescriptions)
  Future<PatientPrescriptionsResponse> getPatientPrescriptions({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @GET(EndPoint.patientPrescriptionDetails)
  Future<PatientRecordDetailResponse> getPatientPrescriptionDetails(
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

  @GET(EndPoint.patientInvoices)
  Future<PatientInvoicesResponse> getPatientInvoices({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @GET(EndPoint.patientInvoice)
  Future<PatientInvoiceResponse> getPatientInvoice(@Path('id') String id);

  @GET(EndPoint.patientInvoiceDownload)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<Uint8List>> downloadPatientInvoice(@Path('id') String id);

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
  Future<DoctorSpecialtiesResponse> getDoctorSpecialties({
    @Query('parentId') String? parentId,
  });

  @GET(EndPoint.specialties)
  Future<PatientSpecialtiesResponse> getPatientSpecialties({
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

  @GET(EndPoint.consultations)
  Future<DoctorConsultationsResponse> getDoctorConsultations();

  @GET(EndPoint.consultations)
  Future<PatientConsultationsResponse> getPatientConsultations();

  @POST(EndPoint.consultationsStart)
  Future<DoctorStartConsultationResponse> startDoctorConsultation(
    @Path('appointmentId') String appointmentId,
    @Body() DoctorStartConsultationRequest request,
  );

  @POST(EndPoint.consultationsStart)
  Future<PatientStartConsultationResponse> startPatientConsultation(
    @Path('appointmentId') String appointmentId,
    @Body() PatientStartConsultationRequest request,
  );

  @GET(EndPoint.consultationMessages)
  Future<DoctorMessagesResponse> getDoctorConsultationMessages(
    @Path('consultationId') String consultationId, {
    @Query('limit') int? limit,
    @Query('before') String? before,
  });

  @GET(EndPoint.consultationMessages)
  Future<PatientMessagesResponse> getPatientConsultationMessages(
    @Path('consultationId') String consultationId, {
    @Query('limit') int? limit,
    @Query('before') String? before,
  });

  @POST(EndPoint.agoraToken)
  Future<DoctorAgoraTokenResponse> getDoctorAgoraToken(
    @Body() DoctorAgoraTokenRequest request,
  );

  @POST(EndPoint.agoraToken)
  Future<PatientAgoraTokenResponse> getPatientAgoraToken(
    @Body() PatientAgoraTokenRequest request,
  );

  @POST(EndPoint.startCall)
  Future<DoctorEndCallResponse> startDoctorCall(
    @Path('appointmentId') String appointmentId,
    @Body() DoctorStartConsultationRequest request,
  );

  @POST(EndPoint.startCall)
  Future<PatientEndCallResponse> startPatientCall(
    @Path('appointmentId') String appointmentId,
    @Body() PatientStartConsultationRequest request,
  );

  @POST(EndPoint.endCall)
  Future<DoctorEndCallResponse> endDoctorCall(
    @Path('callId') String callId,
  );

  @POST(EndPoint.endCall)
  Future<PatientEndCallResponse> endPatientCall(
    @Path('callId') String callId,
  );

  @GET(EndPoint.patientNotifications)
  Future<PatientNotificationsResponse> getPatientNotifications({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('isRead') bool? isRead,
  });

  @PATCH(EndPoint.patientNotificationsReadAll)
  Future<PatientMarkAllReadResponse>
  markAllPatientNotificationsRead();

  @PATCH(EndPoint.patientNotificationRead)
  Future<PatientNotificationReadResponse>
  markPatientNotificationRead(@Path('id') String id);

  @GET(EndPoint.doctorNotifications)
  Future<DoctorNotificationsResponse> getDoctorNotifications({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('isRead') bool? isRead,
  });

  @PATCH(EndPoint.doctorNotificationsReadAll)
  Future<DoctorMarkAllReadResponse>
  markAllDoctorNotificationsRead();

  @PATCH(EndPoint.doctorNotificationRead)
  Future<DoctorNotificationReadResponse>
  markDoctorNotificationRead(@Path('id') String id);
}
