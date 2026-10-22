import 'package:json_annotation/json_annotation.dart';

part 'submit_doctor_professional_request.g.dart';

@JsonSerializable()
class SubmitDoctorProfessionalRequest {
  @JsonKey(name: 'mainSpecialtyId')
  final String mainSpecialtyId;
  @JsonKey(name: 'subSpecialtyIds')
  final List<String> subSpecialtyIds;
  @JsonKey(name: 'consultationFee')
  final num consultationFee;
  @JsonKey(name: 'durationChat')
  final int durationChat;
  @JsonKey(name: 'durationVoice')
  final int durationVoice;
  @JsonKey(name: 'durationVideo')
  final int durationVideo;
  @JsonKey(name: 'experienceYears')
  final int experienceYears;
  @JsonKey(name: 'professionalTitle')
  final String professionalTitle;

  const SubmitDoctorProfessionalRequest({
    required this.mainSpecialtyId,
    required this.subSpecialtyIds,
    required this.consultationFee,
    required this.durationChat,
    required this.durationVoice,
    required this.durationVideo,
    required this.experienceYears,
    required this.professionalTitle,
  });

  factory SubmitDoctorProfessionalRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitDoctorProfessionalRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubmitDoctorProfessionalRequestToJson(this);
}
