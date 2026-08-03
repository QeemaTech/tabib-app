import 'package:equatable/equatable.dart';

class DoctorSpecialtyEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;

  const DoctorSpecialtyEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  String localizedName(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}
