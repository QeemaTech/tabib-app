import 'package:equatable/equatable.dart';

class CouponValidationEntity extends Equatable {
  final String code;
  final String discountType;
  final double discountValue;
  final double discountAmount;
  final double finalAmount;
  final double originalAmount;

  const CouponValidationEntity({
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
    required this.finalAmount,
    required this.originalAmount,
  });

  @override
  List<Object?> get props => [
        code,
        discountType,
        discountValue,
        discountAmount,
        finalAmount,
        originalAmount,
      ];
}
