class EndPoint {
  static const String baseUrl = "https://tabeeb.nodeteam.site/api/v1/";
  static const String socketUrl = "https://tabeeb.nodeteam.site";

  EndPoint._();

  static const String registerPatient = "/auth/patient/register";
  static const String registerDoctor = "/auth/doctor/register";
  static const String sendOtp = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String patientHealthProfile = "/patient/health-profile";
  static const String patientMedicalInfo = "/patient/health-profile/medical-info";
  static const String patientHome = "/patient/home";
  static const String patientDoctorDetails = "/patient/doctors/{id}";
  static const String patientDoctors = "/patient/doctors";
  static const String patientDoctorAvailability =
      "/patient/doctors/{id}/availability";
  static const String patientAppointments = "/patient/appointments";
  static const String patientAppointmentDetails = "/patient/appointments/{id}";
  static const String patientCancelAppointment =
      "/patient/appointments/{id}/cancel";
  static const String patientValidateCoupon =
      "/patient/payments/validate-coupon";
  static const String patientPayments = "/patient/payments";
  static const String patientInvoices = "/patient/invoices";
  static const String patientInvoice = "/patient/invoices/{id}";
  static const String patientInvoiceDownload =
      "/patient/invoices/{id}/download";
  static const String patientWallet = "/patient/wallet";
  static const String doctorWallet = "/doctor/wallet";
  static const String doctorWalletTransactions = "/doctor/wallet/transactions";
  static const String doctorWalletWithdrawals = "/doctor/wallet/withdrawals";
  static const String doctorWalletWithdrawalById =
      "/doctor/wallet/withdrawals/{id}";
  static const String doctorDashboard = "/doctor/dashboard";
  static const String doctorPatients = "/doctor/patients";
  static const String doctorAppointments = "/doctor/appointments";
  static const String doctorAppointmentDetails = "/doctor/appointments/{id}";
  static const String doctorAppointmentReport =
      "/doctor/appointments/{id}/report";
  static const String doctorAppointmentPatientFile =
      "/doctor/appointments/{id}/patient-file";
  static const String doctorAppointmentAccept =
      "/doctor/appointments/{id}/accept";
  static const String doctorAppointmentReject =
      "/doctor/appointments/{id}/reject";
  static const String doctorSchedule = "/doctor/schedule";
  static const String doctorSchedulePreview = "/doctor/schedule/preview";
  static const String doctorScheduleDay = "/doctor/schedule/{dayOfWeek}";
  static const String patientProfile = "/patient/profile";
  static const String doctorProfile = "/doctor/profile";
  static const String specialties = "/specialties";
  static const String doctorProfessionalTitles =
      "/doctor/onboarding/professional-titles";
  static const String doctorOnboardingProfessional =
      "/doctor/onboarding/professional";
  static const String doctorOnboardingDocuments =
      "/doctor/onboarding/documents";
  static const String consultations = "/consultations";
  static const String consultationsStart =
      "/consultations/{appointmentId}/start";
  static const String consultationMessages =
      "/consultations/{consultationId}/messages";
  static const String agoraToken = "/agora/token";
  static const String startCall = "/calls/appointment/{appointmentId}/start";
  static const String endCall = "/calls/{callId}/end";
  static const String registerDevice = "/device/register";
  static const String unregisterDevice = "/device/unregister";


}
