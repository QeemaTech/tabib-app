import 'package:equatable/equatable.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_appointment_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoice_entity.dart';

class PatientAppointmentDetailsEntity extends Equatable {
  final String id;
  final String status;
  final String date;
  final String startTime;
  final String endTime;
  final double bookingPrice;
  final String currency;
  final String complaint;
  final String symptoms;
  final String notes;
  final List<AppointmentChannelEntity> channels;
  final AppointmentDetailsDoctorEntity doctor;
  final PatientAppointmentActionsEntity actions;
  final PatientInvoiceEntity? invoice;

  const PatientAppointmentDetailsEntity({
    required this.id,
    required this.status,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.bookingPrice,
    required this.currency,
    required this.complaint,
    required this.symptoms,
    required this.notes,
    required this.channels,
    required this.doctor,
    required this.actions,
    required this.invoice,
  });

  @override
  List<Object?> get props => [
    id,
    status,
    date,
    startTime,
    endTime,
    bookingPrice,
    currency,
    complaint,
    symptoms,
    notes,
    channels,
    doctor,
    actions,
    invoice,
  ];
}

class AppointmentChannelEntity extends Equatable {
  final String type;
  final String labelAr;
  final String labelEn;
  final int duration;
  final String unit;

  const AppointmentChannelEntity({
    required this.type,
    required this.labelAr,
    required this.labelEn,
    required this.duration,
    required this.unit,
  });

  String localizedLabel(String languageCode) {
    if (languageCode == 'ar' && labelAr.isNotEmpty) return labelAr;
    if (labelEn.isNotEmpty) return labelEn;
    return labelAr;
  }

  @override
  List<Object?> get props => [type, labelAr, labelEn, duration, unit];
}

class AppointmentDetailsDoctorEntity extends Equatable {
  static const offeredModes = ['CHAT', 'VOICE', 'VIDEO'];

  final String id;
  final String fullNameAr;
  final String fullNameEn;
  final String avatarUrl;
  final double ratingAvg;
  final int ratingCount;
  final List<String> channels;
  final List<AppointmentSpecialtyEntity> specialties;
  final AppointmentClinicEntity clinic;

  const AppointmentDetailsDoctorEntity({
    required this.id,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.avatarUrl,
    required this.ratingAvg,
    required this.ratingCount,
    required this.channels,
    required this.specialties,
    required this.clinic,
  });

  static const empty = AppointmentDetailsDoctorEntity(
    id: '',
    fullNameAr: '',
    fullNameEn: '',
    avatarUrl: '',
    ratingAvg: 0,
    ratingCount: 0,
    channels: [],
    specialties: [],
    clinic: AppointmentClinicEntity.empty,
  );

  List<String> get offeredChannels {
    final known = channels
        .map((channel) => channel.toUpperCase())
        .where(offeredModes.contains)
        .toList();
    if (known.isEmpty) return offeredModes;
    return known;
  }

  String localizedName(String languageCode) {
    if (languageCode == 'ar' && fullNameAr.isNotEmpty) return fullNameAr;
    if (fullNameEn.isNotEmpty) return fullNameEn;
    return fullNameAr;
  }

  @override
  List<Object?> get props => [
    id,
    fullNameAr,
    fullNameEn,
    avatarUrl,
    ratingAvg,
    ratingCount,
    channels,
    specialties,
    clinic,
  ];
}

class AppointmentSpecialtyEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;

  const AppointmentSpecialtyEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  String localizedName(String languageCode) {
    if (languageCode == 'ar' && nameAr.isNotEmpty) return nameAr;
    if (nameEn.isNotEmpty) return nameEn;
    return nameAr;
  }

  @override
  List<Object?> get props => [id, nameAr, nameEn];
}

class AppointmentClinicEntity extends Equatable {
  final String nameAr;
  final String addressAr;
  final String phone;
  final String city;

  const AppointmentClinicEntity({
    required this.nameAr,
    required this.addressAr,
    required this.phone,
    required this.city,
  });

  static const empty = AppointmentClinicEntity(
    nameAr: '',
    addressAr: '',
    phone: '',
    city: '',
  );

  bool get hasContent =>
      nameAr.isNotEmpty ||
      addressAr.isNotEmpty ||
      phone.isNotEmpty ||
      city.isNotEmpty;

  @override
  List<Object?> get props => [nameAr, addressAr, phone, city];
}
