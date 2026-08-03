import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/home/domain/entities/featured_doctor_entity.dart';
import 'package:tabib_app/features/home/domain/entities/home_banner_entity.dart';
import 'package:tabib_app/features/home/domain/entities/home_specialty_entity.dart';

class PatientHomeEntity extends Equatable {
  final List<HomeBannerEntity> banners;
  final List<HomeSpecialtyEntity> specialties;
  final List<FeaturedDoctorEntity> featuredDoctors;

  const PatientHomeEntity({
    required this.banners,
    required this.specialties,
    required this.featuredDoctors,
  });

  @override
  List<Object?> get props => [banners, specialties, featuredDoctors];
}
