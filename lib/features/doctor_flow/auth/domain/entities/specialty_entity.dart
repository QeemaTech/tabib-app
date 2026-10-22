import 'package:equatable/equatable.dart';

class SpecialtyEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String? iconUrl;
  final int displayOrder;
  final String? parentId;

  const SpecialtyEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.iconUrl,
    required this.displayOrder,
    this.parentId,
  });

  String localizedName(String languageCode) =>
      languageCode.startsWith('ar') && nameAr.isNotEmpty ? nameAr : nameEn;

  @override
  List<Object?> get props =>
      [id, nameAr, nameEn, iconUrl, displayOrder, parentId];
}
