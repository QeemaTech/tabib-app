import 'package:equatable/equatable.dart';

class DoctorClinicEntity extends Equatable {
  final String id;
  final String nameAr;
  final String addressAr;
  final double lat;
  final double lng;
  final String phone;
  final String city;
  final String country;

  const DoctorClinicEntity({
    required this.id,
    required this.nameAr,
    required this.addressAr,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.city,
    required this.country,
  });

  String get locationLabel {
    if (city.isNotEmpty && country.isNotEmpty) {
      return '$city, $country';
    }
    if (city.isNotEmpty) return city;
    if (addressAr.isNotEmpty) return addressAr;
    return country;
  }

  @override
  List<Object?> get props => [
        id,
        nameAr,
        addressAr,
        lat,
        lng,
        phone,
        city,
        country,
      ];
}
