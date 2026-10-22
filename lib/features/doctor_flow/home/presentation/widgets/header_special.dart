import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/extension/app_extension.dart';

class HeaderSpecial extends StatelessWidget {
  const HeaderSpecial({
    super.key,
    required this.title,
    this.titleArgs,
    this.onSeeMoreClicked,
  });
  final String title;
  final List<String>? titleArgs;
  final void Function()? onSeeMoreClicked;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.tr(args: titleArgs ?? []),
          style: theme.bold24.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.primaryColor500,
            fontSize: 14,
          ),
        ),
        GestureDetector(
            onTap: onSeeMoreClicked,
            child: Text(
            "common.more".tr(),
            style: theme.bold24.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.primaryColor500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
