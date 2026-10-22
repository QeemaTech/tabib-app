import 'package:json_annotation/json_annotation.dart';

part 'validate_coupon_request.g.dart';

@JsonSerializable()
class ValidateCouponRequest {
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;

  ValidateCouponRequest({
    this.code,
    this.appointmentId,
  });

  factory ValidateCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateCouponRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCouponRequestToJson(this);
}
