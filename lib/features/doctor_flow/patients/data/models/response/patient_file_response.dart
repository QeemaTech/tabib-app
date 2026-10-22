import 'package:json_annotation/json_annotation.dart';

part 'patient_file_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientFileResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientFileDataResponse? data;

  PatientFileResponse({
    this.success,
    this.data,
  });

  factory PatientFileResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientFileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientFileDataResponse {
  @JsonKey(name: 'patient')
  final PatientFilePatientResponse? patient;
  @JsonKey(name: 'appointment')
  final PatientFileAppointmentResponse? appointment;
  @JsonKey(name: 'medicalHistory')
  final List<PatientFileMedicalHistoryResponse>? medicalHistory;

  PatientFileDataResponse({
    this.patient,
    this.appointment,
    this.medicalHistory,
  });

  factory PatientFileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientFileDataResponseToJson(this);
}

@JsonSerializable()
class PatientFilePatientResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'bloodType')
  final String? bloodType;
  @JsonKey(name: 'allergies')
  final String? allergies;
  @JsonKey(name: 'chronicConditions')
  final String? chronicConditions;
  @JsonKey(name: 'phone')
  final String? phone;

  PatientFilePatientResponse({
    this.id,
    this.fullNameAr,
    this.gender,
    this.bloodType,
    this.allergies,
    this.chronicConditions,
    this.phone,
  });

  factory PatientFilePatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFilePatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientFilePatientResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientFileAppointmentResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'consultationType')
  final String? consultationType;
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'durationChatHours')
  final int? durationChatHours;
  @JsonKey(name: 'durationCallMinutes')
  final int? durationCallMinutes;
  @JsonKey(name: 'accessWindows')
  final PatientFileAccessWindowsResponse? accessWindows;
  @JsonKey(name: 'permissions')
  final PatientFilePermissionsResponse? permissions;
  @JsonKey(name: 'activeConsultation')
  final dynamic activeConsultation;
  @JsonKey(name: 'activeCall')
  final dynamic activeCall;
  @JsonKey(name: 'notes')
  final String? notes;

  PatientFileAppointmentResponse({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.consultationType,
    this.bookingPrice,
    this.currency,
    this.sessionStartsAt,
    this.durationChatHours,
    this.durationCallMinutes,
    this.accessWindows,
    this.permissions,
    this.activeConsultation,
    this.activeCall,
    this.notes,
  });

  factory PatientFileAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFileAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFileAppointmentResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientFileAccessWindowsResponse {
  @JsonKey(name: 'sessionStartsAt')
  final String? sessionStartsAt;
  @JsonKey(name: 'chat')
  final PatientFileChatWindowResponse? chat;
  @JsonKey(name: 'call')
  final PatientFileCallWindowResponse? call;

  PatientFileAccessWindowsResponse({
    this.sessionStartsAt,
    this.chat,
    this.call,
  });

  factory PatientFileAccessWindowsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientFileAccessWindowsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFileAccessWindowsResponseToJson(this);
}

@JsonSerializable()
class PatientFileChatWindowResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'remainingHours')
  final num? remainingHours;

  PatientFileChatWindowResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.remainingHours,
  });

  factory PatientFileChatWindowResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFileChatWindowResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFileChatWindowResponseToJson(this);
}

@JsonSerializable()
class PatientFileCallWindowResponse {
  @JsonKey(name: 'availableFrom')
  final String? availableFrom;
  @JsonKey(name: 'availableUntil')
  final String? availableUntil;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'durationMinutes')
  final int? durationMinutes;
  @JsonKey(name: 'usedSeconds')
  final int? usedSeconds;
  @JsonKey(name: 'remainingSeconds')
  final int? remainingSeconds;

  PatientFileCallWindowResponse({
    this.availableFrom,
    this.availableUntil,
    this.isActive,
    this.durationMinutes,
    this.usedSeconds,
    this.remainingSeconds,
  });

  factory PatientFileCallWindowResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFileCallWindowResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFileCallWindowResponseToJson(this);
}

@JsonSerializable()
class PatientFilePermissionsResponse {
  @JsonKey(name: 'chat')
  final bool? chat;
  @JsonKey(name: 'call')
  final bool? call;

  PatientFilePermissionsResponse({
    this.chat,
    this.call,
  });

  factory PatientFilePermissionsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientFilePermissionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFilePermissionsResponseToJson(this);
}

@JsonSerializable()
class PatientFileMedicalHistoryResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'summaryAr')
  final String? summaryAr;
  @JsonKey(name: 'diagnoses')
  final List<String>? diagnoses;
  @JsonKey(name: 'prescriptions')
  final int? prescriptions;

  PatientFileMedicalHistoryResponse({
    this.id,
    this.date,
    this.summaryAr,
    this.diagnoses,
    this.prescriptions,
  });

  factory PatientFileMedicalHistoryResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PatientFileMedicalHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientFileMedicalHistoryResponseToJson(this);
}
