import 'package:json_annotation/json_annotation.dart';

part 'validate_coupon_response.g.dart';

@JsonSerializable()
class ValidateCouponResponse {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'data')
  final ValidateCouponDataResponse? data;

  ValidateCouponResponse({
    this.success,
    this.data,
  });

  factory ValidateCouponResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateCouponResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCouponResponseToJson(this);
}

@JsonSerializable()
class ValidateCouponDataResponse {
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'discountType')
  final String? discountType;
  @JsonKey(name: 'discountValue')
  final num? discountValue;
  @JsonKey(name: 'discountAmount')
  final num? discountAmount;
  @JsonKey(name: 'finalAmount')
  final num? finalAmount;
  @JsonKey(name: 'originalAmount')
  final num? originalAmount;

  ValidateCouponDataResponse({
    this.code,
    this.discountType,
    this.discountValue,
    this.discountAmount,
    this.finalAmount,
    this.originalAmount,
  });

  factory ValidateCouponDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateCouponDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateCouponDataResponseToJson(this);
}
