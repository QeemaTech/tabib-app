import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/view_model/patient_invoices_view_model.dart';
import 'package:tabib_app/features/patient_flow/appointments/presentation/widgets/patient_invoices_body.dart';

class PatientInvoicesView extends StatelessWidget {
  const PatientInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocProvider(
      create: (_) => getIt<PatientInvoicesViewModel>()..loadInvoices(),
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'appointments.invoicesTitle'.tr(),
            style: theme.bold18.copyWith(color: theme.textColor600),
          ),
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.textColor600),
        ),
        body: const PatientInvoicesBody(),
      ),
    );
  }
}
