import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/records/domain/entities/patient_record_list_item_entity.dart';

enum RecordsFilter { all, reports, prescriptions }

class RecordsState extends Equatable {
  final RecordsFilter filter;
  final BaseState<List<PatientRecordListItemEntity>> itemsState;
  final List<PatientRecordListItemEntity> reports;
  final List<PatientRecordListItemEntity> prescriptions;
  final int reportsPage;
  final int prescriptionsPage;
  final bool reportsHasMore;
  final bool prescriptionsHasMore;
  final bool isLoadingMore;

  const RecordsState({
    this.filter = RecordsFilter.all,
    this.itemsState = const BaseState(requestState: RequestState.init),
    this.reports = const [],
    this.prescriptions = const [],
    this.reportsPage = 1,
    this.prescriptionsPage = 1,
    this.reportsHasMore = false,
    this.prescriptionsHasMore = false,
    this.isLoadingMore = false,
  });

  bool get hasMore {
    switch (filter) {
      case RecordsFilter.all:
        return reportsHasMore || prescriptionsHasMore;
      case RecordsFilter.reports:
        return reportsHasMore;
      case RecordsFilter.prescriptions:
        return prescriptionsHasMore;
    }
  }

  RecordsState copyWith({
    RecordsFilter? filter,
    BaseState<List<PatientRecordListItemEntity>>? itemsState,
    List<PatientRecordListItemEntity>? reports,
    List<PatientRecordListItemEntity>? prescriptions,
    int? reportsPage,
    int? prescriptionsPage,
    bool? reportsHasMore,
    bool? prescriptionsHasMore,
    bool? isLoadingMore,
  }) {
    return RecordsState(
      filter: filter ?? this.filter,
      itemsState: itemsState ?? this.itemsState,
      reports: reports ?? this.reports,
      prescriptions: prescriptions ?? this.prescriptions,
      reportsPage: reportsPage ?? this.reportsPage,
      prescriptionsPage: prescriptionsPage ?? this.prescriptionsPage,
      reportsHasMore: reportsHasMore ?? this.reportsHasMore,
      prescriptionsHasMore: prescriptionsHasMore ?? this.prescriptionsHasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    filter,
    itemsState,
    reports,
    prescriptions,
    reportsPage,
    prescriptionsPage,
    reportsHasMore,
    prescriptionsHasMore,
    isLoadingMore,
  ];
}
