import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

import '../../../../core/constant/assets_manager.dart';

class SearchBarWidget extends StatelessWidget {
  final String? hintText;
  final void Function()? onTap;
  final bool? readOnly;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const SearchBarWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.readOnly,
    this.onChanged,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onTap: onTap,
      style: theme.regular14.copyWith(color: theme.textColor600),
      decoration: InputDecoration(
        hintText: hintText ?? 'home.search.hint'.tr(),
        hintStyle: theme.regular14.copyWith(color: theme.textColor200),
        prefixIcon: CustomImageView(
          imagePath: AssetsManager.search,
          fit: BoxFit.scaleDown,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: Color(0xFFE5E9F0),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: Color(0xFFE5E9F0),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
    );
  }
}
