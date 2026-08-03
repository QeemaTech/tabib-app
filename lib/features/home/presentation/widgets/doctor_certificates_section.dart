import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/presentation/widgets/details_section.dart';

class DoctorCertificatesSection extends StatelessWidget {
  const DoctorCertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return DetailsSection(
      title: 'home.doctorDetails.certificates'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBulletItem('home.doctorDetails.certificatePhd'.tr(), theme),
          const SizedBox(height: 8),
          _buildBulletItem(
            'home.doctorDetails.certificateFellowship'.tr(),
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, dynamic theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: theme.textColor300,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
        ),
      ],
    );
  }
}
