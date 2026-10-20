import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import 'package:tabib_app/features/home/presentation/widgets/custom_app_bar_profile.dart';

import '../../../../core/constant/assets_manager.dart';
import 'avilable_doc.dart';

class MeetingSection extends StatelessWidget {
  final String? patientName;

  const MeetingSection({super.key, this.patientName});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final displayName = (patientName != null && patientName!.isNotEmpty)
        ? patientName!
        : "appointments.drName".tr();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: const Color(0xFFE8E9EC)),
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33C6BBCA),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x05FFFFFF),
            blurRadius: 0,
            offset: Offset(0, -1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          CustomAppBarProfile(
            title: "home.doctor.sessionStartsNow",
            subTitle: "home.doctor.sessionDescription",
            subTitleArgs: [displayName],
            trailing: AvailableDoc(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF263B73),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(
                              "home.doctor.joinNow".tr(),
                              textAlign: TextAlign.center,
                              style: theme.bold12.copyWith(
                                fontSize: 14,
                                color: theme.whiteColor,
                              ),
                            ),
                            CustomImageView(imagePath: AssetsManager.video),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 4,
                        children: [
                          CustomImageView(imagePath: AssetsManager.report),
                          Text(
                            "home.doctor.appointmentDetails".tr(),
                            textAlign: TextAlign.center,
                            style: theme.bold12.copyWith(
                              fontSize: 14,
                              color: theme.primaryColor500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: const Color(0xFFE8E9EC),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Icon(Icons.access_time, color: theme.primaryColor300),
                  Flexible(
                    child: Text(
                      "home.doctor.entryHint".tr(),
                      textAlign: TextAlign.center,
                      style: theme.medium13.copyWith(
                        color: theme.primaryColor300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
