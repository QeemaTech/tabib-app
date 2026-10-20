import 'package:json_annotation/json_annotation.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_appointments_response.dart';
import 'package:tabib_app/features/appointments/data/models/response/patient_invoice_response.dart';

part 'patient_appointment_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientAppointmentDetailsResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final PatientAppointmentDetailsDataResponse? data;

  PatientAppointmentDetailsResponse({this.success, this.data});

  factory PatientAppointmentDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentDetailsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentDetailsDataResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'startTime')
  final String? startTime;
  @JsonKey(name: 'endTime')
  final String? endTime;
  @JsonKey(name: 'bookingPrice')
  final num? bookingPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'complaint')
  final String? complaint;
  @JsonKey(name: 'symptoms')
  final String? symptoms;
  @JsonKey(name: 'notes')
  final String? notes;
  @JsonKey(name: 'channels')
  final List<PatientAppointmentChannelResponse>? channels;
  @JsonKey(name: 'doctor')
  final PatientAppointmentDetailsDoctorResponse? doctor;
  @JsonKey(name: 'actions')
  final PatientAppointmentActionsResponse? actions;
  @JsonKey(name: 'invoice')
  final PatientInvoiceDataResponse? invoice;

  PatientAppointmentDetailsDataResponse({
    this.id,
    this.status,
    this.date,
    this.startTime,
    this.endTime,
    this.bookingPrice,
    this.currency,
    this.complaint,
    this.symptoms,
    this.notes,
    this.channels,
    this.doctor,
    this.actions,
    this.invoice,
  });

  factory PatientAppointmentDetailsDataResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentDetailsDataResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentChannelResponse {
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'labelAr')
  final String? labelAr;
  @JsonKey(name: 'labelEn')
  final String? labelEn;
  @JsonKey(name: 'duration')
  final num? duration;
  @JsonKey(name: 'unit')
  final String? unit;

  PatientAppointmentChannelResponse({
    this.type,
    this.labelAr,
    this.labelEn,
    this.duration,
    this.unit,
  });

  factory PatientAppointmentChannelResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentChannelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentChannelResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentDetailsDoctorResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'fullNameAr')
  final String? fullNameAr;
  @JsonKey(name: 'fullNameEn')
  final String? fullNameEn;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'ratingAvg')
  final num? ratingAvg;
  @JsonKey(name: 'ratingCount')
  final num? ratingCount;
  @JsonKey(name: 'channels')
  final List<String>? channels;
  @JsonKey(name: 'specialties')
  final List<PatientAppointmentSpecialtyResponse>? specialties;
  @JsonKey(name: 'clinic')
  final PatientAppointmentClinicResponse? clinic;

  PatientAppointmentDetailsDoctorResponse({
    this.id,
    this.fullNameAr,
    this.fullNameEn,
    this.avatarUrl,
    this.ratingAvg,
    this.ratingCount,
    this.channels,
    this.specialties,
    this.clinic,
  });

  factory PatientAppointmentDetailsDoctorResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentDetailsDoctorResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentDetailsDoctorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentSpecialtyResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;

  PatientAppointmentSpecialtyResponse({this.id, this.nameAr, this.nameEn});

  factory PatientAppointmentSpecialtyResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentSpecialtyResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentSpecialtyResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAppointmentClinicResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'addressAr')
  final String? addressAr;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'city')
  final String? city;

  PatientAppointmentClinicResponse({
    this.id,
    this.nameAr,
    this.addressAr,
    this.phone,
    this.city,
  });

  factory PatientAppointmentClinicResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$PatientAppointmentClinicResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PatientAppointmentClinicResponseToJson(this);
}
