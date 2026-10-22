import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/core/utilities/custom_toast.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_actions_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordDetailsActions extends StatelessWidget {
  final PatientRecordActionsEntity actions;

  const RecordDetailsActions({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    if (!actions.hasAny) return const SizedBox.shrink();

    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: theme.blackColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (actions.showFollowUp)
            Expanded(
              flex: 2,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.doctorDetailsView,
                    arguments: actions.doctorId,
                  );
                },
                child: Text(
                  'records.details.bookFollowUp'.tr(),
                  style: theme.medium16.copyWith(color: theme.primaryColor),
                ),
              ),
            ),
          if (actions.showFollowUp && actions.showDownload)
            const SizedBox(width: 12),
          if (actions.showDownload)
            Expanded(
              flex: 3,
              child: ElevatedButton.icon(
                onPressed: () => _openDownload(context),
                icon: CustomImageView(imagePath: AssetsManager.download),
                label: Text(
                  'records.details.downloadPDF'.tr(),
                  style: theme.medium16.copyWith(color: theme.whiteColor),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _openDownload(BuildContext context) async {
    final uri = Uri.tryParse(actions.downloadPdfUrl);
    final opened =
        uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      CustomToast.error(context, 'records.details.downloadFailed'.tr());
    }
  }
}
