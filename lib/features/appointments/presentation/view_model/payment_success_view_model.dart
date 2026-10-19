import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';
import 'package:tabib_app/features/appointments/domain/repo/appointments_repo.dart';
import 'package:tabib_app/features/appointments/presentation/view_model/payment_success_state.dart';

@injectable
class PaymentSuccessViewModel extends Cubit<PaymentSuccessState> {
  final AppointmentsRepo appointmentsRepo;

  PaymentSuccessViewModel({required this.appointmentsRepo})
    : super(const PaymentSuccessState());

  Future<void> loadInvoice(String id) async {
    final invoiceId = id.trim();
    if (invoiceId.isEmpty) {
      emit(
        state.copyWith(
          invoiceState: BaseState.error('appointments.invoiceUnavailable'.tr()),
        ),
      );
      return;
    }

    emit(state.copyWith(invoiceState: BaseState.loading()));
    final result = await appointmentsRepo.getInvoice(invoiceId);
    switch (result) {
      case Success<PatientInvoiceEntity>():
        emit(state.copyWith(invoiceState: BaseState.loaded(result.data)));
      case Failure<PatientInvoiceEntity>():
        emit(
          state.copyWith(invoiceState: BaseState.error(result.errorMessage)),
        );
    }
  }
}
