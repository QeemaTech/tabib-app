import 'package:equatable/equatable.dart';

class HomeBannerEntity extends Equatable {
  final String id;
  final String titleAr;
  final String titleEn;
  final String imageUrl;
  final String? linkUrl;

  const HomeBannerEntity({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.imageUrl,
    this.linkUrl,
  });

  String localizedTitle(String languageCode) =>
      languageCode == 'ar' ? titleAr : titleEn;

  @override
  List<Object?> get props => [id, titleAr, titleEn, imageUrl, linkUrl];
}
