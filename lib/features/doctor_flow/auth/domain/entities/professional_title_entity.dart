import 'package:equatable/equatable.dart';

class ProfessionalTitleEntity extends Equatable {
  final String value;
  final String nameAr;
  final String nameEn;

  const ProfessionalTitleEntity({
    required this.value,
    required this.nameAr,
    required this.nameEn,
  });

  String localizedName(String languageCode) =>
      languageCode.startsWith('ar') && nameAr.isNotEmpty ? nameAr : nameEn;

  @override
  List<Object?> get props => [value, nameAr, nameEn];
}
