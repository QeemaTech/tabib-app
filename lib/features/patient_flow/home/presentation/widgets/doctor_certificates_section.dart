import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/doctor_certificate_entity.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/certificate_bullet_item.dart';
import 'package:tabib_app/core/widgets/details_section.dart';

class DoctorCertificatesSection extends StatelessWidget {
  final List<DoctorCertificateEntity> certificates;

  const DoctorCertificatesSection({
    super.key,
    required this.certificates,
  });

  @override
  Widget build(BuildContext context) {
    if (certificates.isEmpty) {
      return const SizedBox.shrink();
    }

    final languageCode = context.locale.languageCode;

    return DetailsSection(
      title: 'home.doctorDetails.certificates'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < certificates.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            CertificateBulletItem(
              text: certificates[i].localizedTitle(languageCode),
            ),
          ],
        ],
      ),
    );
  }
}
