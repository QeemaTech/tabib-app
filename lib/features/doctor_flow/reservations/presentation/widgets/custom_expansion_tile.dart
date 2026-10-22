import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final List<Widget> children;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: ExpansionTile(
          maintainState: true,
          trailing: Icon(
            Icons.keyboard_arrow_down,
            color: theme.textColor300,
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
            ),
          ),
          title: Text(
            title,
            style: theme.bold18.copyWith(fontSize: 16, color: theme.textColor600),
          ),
          childrenPadding: const EdgeInsets.all(16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
