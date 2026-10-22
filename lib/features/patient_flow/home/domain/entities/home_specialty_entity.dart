import 'package:equatable/equatable.dart';

class HomeSpecialtyEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String? iconUrl;

  const HomeSpecialtyEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.iconUrl,
  });

  String localizedName(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [id, nameAr, nameEn, iconUrl];
}
