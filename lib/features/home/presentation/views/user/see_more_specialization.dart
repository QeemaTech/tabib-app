import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/constant/assets_manager.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/features/auth/domain/entities/specialty_entity.dart';
import 'package:tabib_app/features/home/presentation/view_model/specialties_state.dart';
import 'package:tabib_app/features/home/presentation/view_model/specialties_view_model.dart';
import 'package:tabib_app/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:tabib_app/features/home/presentation/widgets/special_item.dart';

class SeeMoreSpecializationView extends StatelessWidget {
  const SeeMoreSpecializationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

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
            padding: const EdgeInsets.all(16),
            child: SearchBarWidget(
              hintText: 'home.search.specHint'.tr(),
              onChanged: context.read<SpecialtiesViewModel>().onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<SpecialtiesViewModel, SpecialtiesState>(
              builder: (context, state) {
                final specialtiesState = state.specialtiesState;
                if (specialtiesState.isLoading || specialtiesState.isInitial) {
                  return const SpecialtiesLoadingBody();
                }
                if (specialtiesState.isError) {
                  return _SpecialtiesErrorWidget(
                    message: specialtiesState.errorMessage ?? '',
                  );
                }
                return _SpecialtiesSuccessWidget(
                  specialties: state.filteredSpecialties(
                    context.locale.languageCode,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialtiesLoadingBody extends StatelessWidget {
  const SpecialtiesLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        itemCount: 9,
        itemBuilder: (_, _) => const SpecialItem(
          title: 'Specialty',
          image: AssetsManager.skinDoc,
        ),
      ),
    );
  }
}

class _SpecialtiesErrorWidget extends StatelessWidget {
  final String message;

  const _SpecialtiesErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.regular14.copyWith(color: theme.textColor300),
          ),
          IconButton(
            onPressed: () => context.read<SpecialtiesViewModel>().retry(),
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}

class _SpecialtiesSuccessWidget extends StatelessWidget {
  final List<SpecialtyEntity> specialties;

  const _SpecialtiesSuccessWidget({required this.specialties});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final languageCode = context.locale.languageCode;

    if (specialties.isEmpty) {
      return Center(
        child: Text(
          'home.search.empty'.tr(),
          style: theme.regular14.copyWith(color: theme.textColor300),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        final specialty = specialties[index];
        final iconUrl = specialty.iconUrl;
        return InkWell(
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
        );
      },
    );
  }
}
