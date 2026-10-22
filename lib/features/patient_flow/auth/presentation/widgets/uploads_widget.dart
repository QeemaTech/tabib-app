import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/utilities/custom_image_view.dart';

class UploadsWidget extends StatelessWidget {
  const UploadsWidget({super.key, required this.hintText, this.onTap, this.widget});
  final String hintText;
  final void Function()? onTap;
final Widget?widget;
  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadows: const [
            BoxShadow(
              color: Color(0x33C9C9C9),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(hintText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.regular14.copyWith(

                      color: theme.textColor200,
                ),
              ),
            ),
            widget ?? CustomImageView(imagePath: AssetsManager.upload),
          ],
        ),
      ),
    );
  }
}
