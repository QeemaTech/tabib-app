import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/search_bar_widget.dart';

class SearchViewHeader extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchViewHeader({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.textColor100.withValues(alpha: 0.5),
              ),
            ),
            child: Icon(Icons.tune, color: theme.primaryColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SearchBarWidget(
              controller: controller,
              hintText: 'home.search.hint'.tr(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
