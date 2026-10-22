import 'package:equatable/equatable.dart';

class DoctorReviewEntity extends Equatable {
  final String id;
  final double rating;
  final String commentAr;
  final String commentEn;
  final String patientName;

  const DoctorReviewEntity({
    required this.id,
    required this.rating,
    required this.commentAr,
    required this.commentEn,
    required this.patientName,
  });

  String localizedComment(String languageCode) {
    if (languageCode == 'ar') {
      return commentAr.isNotEmpty ? commentAr : commentEn;
    }
    return commentEn.isNotEmpty ? commentEn : commentAr;
  }

  @override
  List<Object?> get props => [
        id,
        rating,
        commentAr,
        commentEn,
        patientName,
      ];
}
