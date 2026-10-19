import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/invoice_file_entity.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoices_page_entity.dart';
import 'package:tabib_app/features/appointments/domain/repo/appointments_repo.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/patient_invoices_state.dart';

@injectable
class PatientInvoicesViewModel extends Cubit<PatientInvoicesState> {
  final AppointmentsRepo appointmentsRepo;
  static const _pageLimit = 20;

  PatientInvoicesViewModel({required this.appointmentsRepo})
    : super(const PatientInvoicesState());

  Future<void> loadInvoices({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(invoicesState: BaseState.loading()));
    }
    final result = await appointmentsRepo.getInvoices(
      page: 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<PatientInvoicesPageEntity>():
        emit(
          state.copyWith(
            invoicesState: BaseState.loaded(result.data.items),
            page: result.data.page,
            hasMore: result.data.hasMore,
            isLoadingMore: false,
          ),
        );
      case Failure<PatientInvoicesPageEntity>():
        emit(
          state.copyWith(
            invoicesState: BaseState.error(result.errorMessage),
            isLoadingMore: false,
          ),
        );
    }
  }

  Future<void> loadMoreInvoices() async {
    if (!state.hasMore || state.isLoadingMore || state.invoicesState.isLoading) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true));
    final result = await appointmentsRepo.getInvoices(
      page: state.page + 1,
      limit: _pageLimit,
    );
    switch (result) {
      case Success<PatientInvoicesPageEntity>():
        final current = state.invoicesState.data ?? const [];
        emit(
          state.copyWith(
            invoicesState: BaseState.loaded([
              ...current,
              ...result.data.items,
            ]),
            page: result.data.page,
            hasMore: result.data.hasMore,
            isLoadingMore: false,
          ),
        );
      case Failure<PatientInvoicesPageEntity>():
        emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> downloadInvoice(String id) async {
    if (state.downloadingInvoiceId != null) return;
    emit(
      state.copyWith(
        downloadingInvoiceId: id,
        downloadState: const BaseState(requestState: RequestState.init),
      ),
    );
    final result = await appointmentsRepo.downloadInvoice(id);
    switch (result) {
      case Success<InvoiceFileEntity>():
        emit(
          state.copyWith(
            clearDownloading: true,
            downloadState: BaseState.loaded(result.data),
          ),
        );
      case Failure<InvoiceFileEntity>():
        emit(
          state.copyWith(
            clearDownloading: true,
            downloadState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }
}
