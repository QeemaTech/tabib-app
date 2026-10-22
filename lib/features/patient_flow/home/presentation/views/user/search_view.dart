import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/home/domain/entities/search_doctor_entity.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/search_doctors_state.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/view_model/search_doctors_view_model.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/doctor_search_card.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/search_doctor_result_card.dart';
import 'package:tabib_app/features/patient_flow/home/presentation/widgets/search_view_header.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('home.search.title'.tr(), style: theme.bold18),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SearchViewHeader(
            controller: _searchController,
            onChanged: context.read<SearchDoctorsViewModel>().onSearchChanged,
          ),
          Expanded(
            child: BlocBuilder<SearchDoctorsViewModel, SearchDoctorsState>(
              buildWhen: (previous, current) =>
                  previous.searchState != current.searchState,
              builder: (context, state) {
                final searchState = state.searchState;
                if (searchState.isLoading || searchState.isInitial) {
                  return const _SearchLoadingWidget();
                }
                if (searchState.isError) {
                  return _SearchErrorWidget(
                    message: searchState.errorMessage ?? '',
                  );
                }
                return _SearchSuccessWidget(
                  doctors: searchState.data?.doctors ?? const [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchLoadingWidget extends StatelessWidget {
  const _SearchLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, _) => const DoctorSearchCard(
          name: 'Doctor Name',
          specialty: 'Specialty',
          rating: 4.5,
          appointmentsCount: '20',
          specializations: ['Specialty One', 'Specialty Two'],
          date: 'Clinic',
          time: 'City',
          price: '15',
        ),
      ),
    );
  }
}

class _SearchErrorWidget extends StatelessWidget {
  final String message;

  const _SearchErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<SearchDoctorsViewModel>().refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.regular14.copyWith(color: theme.textColor300),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<SearchDoctorsViewModel>().retry(),
                    icon: Icon(Icons.refresh, color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchSuccessWidget extends StatelessWidget {
  final List<SearchDoctorEntity> doctors;

  const _SearchSuccessWidget({required this.doctors});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return RefreshIndicator(
      color: theme.primaryColor,
      onRefresh: () => context.read<SearchDoctorsViewModel>().refresh(),
      child: doctors.isEmpty
          ? CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'home.search.empty'.tr(),
                      style:
                          theme.regular14.copyWith(color: theme.textColor300),
                    ),
                  ),
                ),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: doctors.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) =>
                  SearchDoctorResultCard(doctor: doctors[index]),
            ),
    );
  }
}
