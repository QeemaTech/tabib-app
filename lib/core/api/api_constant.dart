class EndPoint {
  static const String baseUrl = "https://tabeeb.nodeteam.site/api/v1/";

  EndPoint._();

  static const String registerPatient = "/auth/patient/register";
  static const String registerDoctor = "/auth/doctor/register";
  static const String sendOtp = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String patientHealthProfile = "/patient/health-profile";
  static const String patientMedicalInfo = "/patient/health-profile/medical-info";
  static const String patientHome = "/patient/home";
  static const String patientDoctorDetails = "/patient/doctors/{id}";
  static const String patientDoctorAvailability =
      "/patient/doctors/{id}/availability";
  static const String patientAppointments = "/patient/appointments";
  static const String patientCancelAppointment =
      "/patient/appointments/{id}/cancel";
}
