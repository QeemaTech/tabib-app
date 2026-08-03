import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/home/presentation/widgets/special_item.dart';
import 'package:tabib_app/features/home/presentation/widgets/search_bar_widget.dart';

class SpecializationsData {
  final String title;
  final String imageUrl;

  SpecializationsData({required this.title, required this.imageUrl});
}

class SeeMoreSpecializationView extends StatelessWidget {
  const SeeMoreSpecializationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final List<SpecializationsData> specializations = [
      SpecializationsData(title: "common.kids".tr(), imageUrl: AssetsManager.doctor),
      SpecializationsData(title: "common.kids".tr(), imageUrl: AssetsManager.doctor),
      SpecializationsData(title: "common.kids".tr(), imageUrl: AssetsManager.doctor),
      SpecializationsData(title: "common.kids".tr(), imageUrl: AssetsManager.doctor),
    ];

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'home.search.specializations'.tr(),
          style: theme.bold18.copyWith(color: theme.textColor600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.textColor600, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              hintText: 'home.search.specHint'.tr(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: specializations.length,
              itemBuilder: (context, index) {
                return SpecialItem(
                  title: specializations[index].title,
                  image: specializations[index].imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
