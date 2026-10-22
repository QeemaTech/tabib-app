import 'package:json_annotation/json_annotation.dart';

part 'doctor_professional_response.g.dart';

@JsonSerializable()
class DoctorProfessionalResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final DoctorProfessionalDataResponse? data;

  DoctorProfessionalResponse({this.success, this.data});

  factory DoctorProfessionalResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfessionalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorProfessionalResponseToJson(this);
}

@JsonSerializable()
class DoctorProfessionalDataResponse {
  @JsonKey(name: 'experienceYears')
  final int? experienceYears;
  @JsonKey(name: 'professionalTitle')
  final String? professionalTitle;
  @JsonKey(name: 'professionalTitleAr')
  final String? professionalTitleAr;
  @JsonKey(name: 'mainSpecialty')
  final DoctorSpecialtyRefResponse? mainSpecialty;
  @JsonKey(name: 'subSpecialties')
  final List<DoctorSpecialtyRefResponse>? subSpecialties;
  @JsonKey(name: 'consultationFee')
  final num? consultationFee;
  @JsonKey(name: 'feeChat')
  final num? feeChat;
  @JsonKey(name: 'feeVoice')
  final num? feeVoice;
  @JsonKey(name: 'feeVideo')
  final num? feeVideo;
  @JsonKey(name: 'durationChat')
  final int? durationChat;
  @JsonKey(name: 'durationVoice')
  final int? durationVoice;
  @JsonKey(name: 'durationVideo')
  final int? durationVideo;

  DoctorProfessionalDataResponse({
    this.experienceYears,
    this.professionalTitle,
    this.professionalTitleAr,
    this.mainSpecialty,
    this.subSpecialties,
    this.consultationFee,
    this.feeChat,
    this.feeVoice,
    this.feeVideo,
    this.durationChat,
    this.durationVoice,
    this.durationVideo,
  });

  factory DoctorProfessionalDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorProfessionalDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DoctorProfessionalDataResponseToJson(this);
}

@JsonSerializable()
class DoctorSpecialtyRefResponse {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'nameAr')
  final String? nameAr;
  @JsonKey(name: 'nameEn')
  final String? nameEn;

  DoctorSpecialtyRefResponse({this.id, this.nameAr, this.nameEn});

  factory DoctorSpecialtyRefResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorSpecialtyRefResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSpecialtyRefResponseToJson(this);
}
