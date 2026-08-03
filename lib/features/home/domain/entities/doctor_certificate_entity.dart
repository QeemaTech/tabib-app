import 'package:equatable/equatable.dart';

class DoctorCertificateEntity extends Equatable {
  final String id;
  final String titleAr;
  final String titleEn;
  final String? imageUrl;

  const DoctorCertificateEntity({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    this.imageUrl,
  });

  String localizedTitle(String languageCode) {
    if (languageCode == 'ar') {
      return titleAr.isNotEmpty ? titleAr : titleEn;
    }
    return titleEn.isNotEmpty ? titleEn : titleAr;
  }

  @override
  List<Object?> get props => [id, titleAr, titleEn, imageUrl];
}
