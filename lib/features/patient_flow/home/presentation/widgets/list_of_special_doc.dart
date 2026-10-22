import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/home_specialty_entity.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/special_item.dart';

class ListOfSpecialDoc extends StatelessWidget {
  final List<HomeSpecialtyEntity> specialties;

  const ListOfSpecialDoc({super.key, required this.specialties});

  @override
  Widget build(BuildContext context) {
    if (specialties.isEmpty) {
      return const SizedBox.shrink();
    }

    final languageCode = context.locale.languageCode;

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final iconUrl = specialty.iconUrl;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.searchView,
                  arguments: specialty.id,
                );
              },
              child: SpecialItem(
                title: specialty.localizedName(languageCode),
                image: (iconUrl != null && iconUrl.isNotEmpty)
                    ? iconUrl
                    : AssetsManager.skinDoc,
              ),
            ),
          );
        },
      ),
    );
  }
}
