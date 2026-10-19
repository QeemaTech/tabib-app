import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/appointments/domain/entities/patient_invoice_entity.dart';

class PaymentSuccessState extends Equatable {
  final BaseState<PatientInvoiceEntity> invoiceState;

  const PaymentSuccessState({
    this.invoiceState = const BaseState(requestState: RequestState.init),
  });

  PaymentSuccessState copyWith({
    BaseState<PatientInvoiceEntity>? invoiceState,
  }) {
    return PaymentSuccessState(invoiceState: invoiceState ?? this.invoiceState);
  }

  @override
  List<Object?> get props => [invoiceState];
}
