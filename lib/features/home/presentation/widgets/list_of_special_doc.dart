import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/assets_manager.dart';
import '../../../../core/extension/app_extension.dart';
import '../../../../core/utilities/custom_image_view.dart';

class ListOfSpecialDoc extends StatelessWidget {
  const ListOfSpecialDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: SpecialItem(
              title: 'common.kids'.tr(),
              image: AssetsManager.skinDoc,
            ),
          );
        },
      ),
    );
  }
}

class SpecialItem extends StatelessWidget {
  final String title;
  final String image;
  const SpecialItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: image,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.bold12.copyWith(fontSize: 14, color: theme.primaryColor500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
