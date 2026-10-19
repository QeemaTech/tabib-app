import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';
import '../../../../core/constant/assets_manager.dart';

class CustomAppBarProfile extends StatelessWidget {
  const CustomAppBarProfile({
    super.key,
    required this.title,
    required this.subTitle,
    this.subTitleArgs,
    this.trailing,
    this.onMessageClicked,
    this.onNotificationClicked,
    this.onProfileImageClicked,
  });
  final String title;
  final String subTitle;
  final List<String>? subTitleArgs;
  final void Function()? onMessageClicked;
  final void Function()? onNotificationClicked;
  final void Function()? onProfileImageClicked;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CustomImageView(
          imagePath: AssetsManager.user,
          height: 56,
          width: 56,
          radius: BorderRadius.circular(50),
          onTap: onProfileImageClicked,
        ),

        title: Text(
          title.tr(),
          style: theme.medium16.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Text(
          subTitle.tr(args: subTitleArgs ?? []),
          style: theme.bold12.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),

        trailing:
            trailing ??
            SizedBox(
              width: 80,
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomImageView(
                    onTap: onMessageClicked,
                    imagePath: AssetsManager.messages,
                    height: 24,
                  ),
                  CustomImageView(
                    onTap: onNotificationClicked,
                    imagePath: AssetsManager.notification,
                    height: 24,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
