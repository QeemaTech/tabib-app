import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/records/presentation/view_model/report_details_view_model.dart';
import 'package:tabib_app/features/records/presentation/widgets/report_details_body.dart';

class ReportDetailsView extends StatelessWidget {
  final String reportId;

  const ReportDetailsView({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReportDetailsViewModel>()..load(reportId),
      child: ReportDetailsBody(reportId: reportId),
    );
  }
}
