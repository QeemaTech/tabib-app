import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_list_item_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/entities/patient_record_page_entity.dart';
import 'package:tabib_app/features/patient_flow/records/domain/repo/records_repo.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/view_model/records_state.dart';

@injectable
class RecordsViewModel extends Cubit<RecordsState> {
  final RecordsRepo recordsRepo;
  static const _pageLimit = 20;
  int _requestId = 0;

  RecordsViewModel({required this.recordsRepo}) : super(const RecordsState());

  Future<void> load() => selectFilter(state.filter);

  Future<void> selectFilter(RecordsFilter filter) async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        filter: filter,
        itemsState: BaseState.loading(),
        reports: const [],
        prescriptions: const [],
        reportsPage: 1,
        prescriptionsPage: 1,
        reportsHasMore: false,
        prescriptionsHasMore: false,
        isLoadingMore: false,
      ),
    );
    await _fetchFirstPage(filter, requestId);
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.itemsState.isLoading) {
      return;
    }
    final requestId = _requestId;
    final filter = state.filter;
    emit(state.copyWith(isLoadingMore: true));

    switch (filter) {
      case RecordsFilter.reports:
        await _appendReports(requestId);
      case RecordsFilter.prescriptions:
        await _appendPrescriptions(requestId);
      case RecordsFilter.all:
        await _appendAll(requestId);
    }
  }

  Future<void> _fetchFirstPage(RecordsFilter filter, int requestId) async {
    switch (filter) {
      case RecordsFilter.reports:
        final result = await recordsRepo.getReports(page: 1, limit: _pageLimit);
        if (!_isCurrent(requestId)) return;
        switch (result) {
          case Success<PatientRecordPageEntity>():
            _emitLoaded(
              reports: result.data.items,
              reportsPage: result.data.page,
              reportsHasMore: result.data.hasMore,
              prescriptions: const [],
              prescriptionsPage: 1,
              prescriptionsHasMore: false,
            );
          case Failure<PatientRecordPageEntity>():
            emit(
              state.copyWith(
                itemsState: BaseState.error(result.errorMessage),
                isLoadingMore: false,
              ),
            );
        }
      case RecordsFilter.prescriptions:
        final result = await recordsRepo.getPrescriptions(
          page: 1,
          limit: _pageLimit,
        );
        if (!_isCurrent(requestId)) return;
        switch (result) {
          case Success<PatientRecordPageEntity>():
            _emitLoaded(
              reports: const [],
              reportsPage: 1,
              reportsHasMore: false,
              prescriptions: result.data.items,
              prescriptionsPage: result.data.page,
              prescriptionsHasMore: result.data.hasMore,
            );
          case Failure<PatientRecordPageEntity>():
            emit(
              state.copyWith(
                itemsState: BaseState.error(result.errorMessage),
                isLoadingMore: false,
              ),
            );
        }
      case RecordsFilter.all:
        final (reportsResult, prescriptionsResult) = await (
          recordsRepo.getReports(page: 1, limit: _pageLimit),
          recordsRepo.getPrescriptions(page: 1, limit: _pageLimit),
        ).wait;
        if (!_isCurrent(requestId)) return;
        if (reportsResult is Failure<PatientRecordPageEntity>) {
          emit(
            state.copyWith(
              itemsState: BaseState.error(reportsResult.errorMessage),
              isLoadingMore: false,
            ),
          );
          return;
        }
        if (prescriptionsResult is Failure<PatientRecordPageEntity>) {
          emit(
            state.copyWith(
              itemsState: BaseState.error(prescriptionsResult.errorMessage),
              isLoadingMore: false,
            ),
          );
          return;
        }
        final reports = reportsResult as Success<PatientRecordPageEntity>;
        final prescriptions =
            prescriptionsResult as Success<PatientRecordPageEntity>;
        _emitLoaded(
          reports: reports.data.items,
          reportsPage: reports.data.page,
          reportsHasMore: reports.data.hasMore,
          prescriptions: prescriptions.data.items,
          prescriptionsPage: prescriptions.data.page,
          prescriptionsHasMore: prescriptions.data.hasMore,
        );
    }
  }

  Future<void> _appendReports(int requestId) async {
    final result = await recordsRepo.getReports(
      page: state.reportsPage + 1,
      limit: _pageLimit,
    );
    if (!_isCurrent(requestId)) return;
    switch (result) {
      case Success<PatientRecordPageEntity>():
        _emitLoaded(
          reports: [...state.reports, ...result.data.items],
          reportsPage: result.data.page,
          reportsHasMore: result.data.hasMore,
          prescriptions: state.prescriptions,
          prescriptionsPage: state.prescriptionsPage,
          prescriptionsHasMore: state.prescriptionsHasMore,
        );
      case Failure<PatientRecordPageEntity>():
        emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _appendPrescriptions(int requestId) async {
    final result = await recordsRepo.getPrescriptions(
      page: state.prescriptionsPage + 1,
      limit: _pageLimit,
    );
    if (!_isCurrent(requestId)) return;
    switch (result) {
      case Success<PatientRecordPageEntity>():
        _emitLoaded(
          reports: state.reports,
          reportsPage: state.reportsPage,
          reportsHasMore: state.reportsHasMore,
          prescriptions: [...state.prescriptions, ...result.data.items],
          prescriptionsPage: result.data.page,
          prescriptionsHasMore: result.data.hasMore,
        );
      case Failure<PatientRecordPageEntity>():
        emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _appendAll(int requestId) async {
    final reportsFuture = state.reportsHasMore
        ? recordsRepo.getReports(page: state.reportsPage + 1, limit: _pageLimit)
        : null;
    final prescriptionsFuture = state.prescriptionsHasMore
        ? recordsRepo.getPrescriptions(
            page: state.prescriptionsPage + 1,
            limit: _pageLimit,
          )
        : null;
    final reportsResult = reportsFuture == null ? null : await reportsFuture;
    final prescriptionsResult = prescriptionsFuture == null
        ? null
        : await prescriptionsFuture;
    if (!_isCurrent(requestId)) return;

    var reports = state.reports;
    var reportsPage = state.reportsPage;
    var reportsHasMore = state.reportsHasMore;
    var prescriptions = state.prescriptions;
    var prescriptionsPage = state.prescriptionsPage;
    var prescriptionsHasMore = state.prescriptionsHasMore;

    if (reportsResult is Success<PatientRecordPageEntity>) {
      reports = [...reports, ...reportsResult.data.items];
      reportsPage = reportsResult.data.page;
      reportsHasMore = reportsResult.data.hasMore;
    }
    if (prescriptionsResult is Success<PatientRecordPageEntity>) {
      prescriptions = [...prescriptions, ...prescriptionsResult.data.items];
      prescriptionsPage = prescriptionsResult.data.page;
      prescriptionsHasMore = prescriptionsResult.data.hasMore;
    }

    _emitLoaded(
      reports: reports,
      reportsPage: reportsPage,
      reportsHasMore: reportsHasMore,
      prescriptions: prescriptions,
      prescriptionsPage: prescriptionsPage,
      prescriptionsHasMore: prescriptionsHasMore,
    );
  }

  void _emitLoaded({
    required List<PatientRecordListItemEntity> reports,
    required int reportsPage,
    required bool reportsHasMore,
    required List<PatientRecordListItemEntity> prescriptions,
    required int prescriptionsPage,
    required bool prescriptionsHasMore,
  }) {
    emit(
      state.copyWith(
        itemsState: BaseState.loaded(
          _visible(
            filter: state.filter,
            reports: reports,
            prescriptions: prescriptions,
          ),
        ),
        reports: reports,
        prescriptions: prescriptions,
        reportsPage: reportsPage,
        prescriptionsPage: prescriptionsPage,
        reportsHasMore: reportsHasMore,
        prescriptionsHasMore: prescriptionsHasMore,
        isLoadingMore: false,
      ),
    );
  }

  bool _isCurrent(int requestId) => requestId == _requestId && !isClosed;
}

List<PatientRecordListItemEntity> _visible({
  required RecordsFilter filter,
  required List<PatientRecordListItemEntity> reports,
  required List<PatientRecordListItemEntity> prescriptions,
}) {
  switch (filter) {
    case RecordsFilter.reports:
      return reports;
    case RecordsFilter.prescriptions:
      return prescriptions;
    case RecordsFilter.all:
      final merged = [...reports, ...prescriptions];
      merged.sort(_byDateDesc);
      return merged;
  }
}

int _byDateDesc(PatientRecordListItemEntity a, PatientRecordListItemEntity b) {
  final aDate = DateTime.tryParse(a.occurredAt);
  final bDate = DateTime.tryParse(b.occurredAt);
  if (aDate == null && bDate == null) return 0;
  if (aDate == null) return 1;
  if (bDate == null) return -1;
  return bDate.compareTo(aDate);
}
