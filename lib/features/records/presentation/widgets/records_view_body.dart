import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/widgets/filter_chips.dart';
import 'package:tabib_app/features/records/presentation/view_model/records_state.dart';
import 'package:tabib_app/features/records/presentation/view_model/records_view_model.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_error_view.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_list.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_loading_view.dart';

class RecordsViewBody extends StatelessWidget {
  const RecordsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterChips(
          filters: [
            'records.filters.all'.tr(),
            'records.filters.reports'.tr(),
            'records.filters.prescriptions'.tr(),
          ],
          onSelected: (index) {
            final filter = switch (index) {
              1 => RecordsFilter.reports,
              2 => RecordsFilter.prescriptions,
              _ => RecordsFilter.all,
            };
            context.read<RecordsViewModel>().selectFilter(filter);
          },
        ),
        Expanded(
          child: BlocBuilder<RecordsViewModel, RecordsState>(
            buildWhen: (previous, current) =>
                previous.itemsState != current.itemsState ||
                previous.isLoadingMore != current.isLoadingMore ||
                previous.reportsHasMore != current.reportsHasMore ||
                previous.prescriptionsHasMore != current.prescriptionsHasMore,
            builder: (context, state) {
              final itemsState = state.itemsState;
              if (itemsState.isLoading || itemsState.isInitial) {
                return const RecordsLoadingView();
              }
              if (itemsState.isError) {
                return RecordsErrorView(message: itemsState.errorMessage ?? '');
              }
              return RecordsList(
                items: itemsState.data ?? const [],
                isLoadingMore: state.isLoadingMore,
                hasMore: state.hasMore,
              );
            },
          ),
        ),
      ],
    );
  }
}
