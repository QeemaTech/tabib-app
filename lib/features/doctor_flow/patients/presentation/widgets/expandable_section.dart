import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final String? iconPath;
  final Widget child;
  final bool isExpanded;
  final Color? backgroundColor;

  const ExpandableSection({
    super.key,
    required this.title,
    this.iconPath,
    required this.child,
    this.isExpanded = false,
    this.backgroundColor,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.textColor100.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: theme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (value) {
              setState(() {
                _isExpanded = value;
              });
            },
            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: theme.textColor300,
            ),
            leading: widget.iconPath != null
                ? Container(
                    padding: const EdgeInsets.all(4),
                    decoration: ShapeDecoration(
                      color: widget.backgroundColor ?? theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: CustomImageView(imagePath: widget.iconPath),
                  )
                : null,
            title: Text(
              widget.title,
              textAlign: TextAlign.end,
              style: theme.bold18.copyWith(
                color: theme.textColor300,
                fontSize: 14,
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.textColor100.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
