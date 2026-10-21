import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/extension/app_extension.dart';
import 'package:tabib_app/features/records/presentation/view_model/prescription_details_state.dart';
import 'package:tabib_app/features/records/presentation/view_model/prescription_details_view_model.dart';
import 'package:tabib_app/features/records/presentation/widgets/prescription_details_content.dart';
import 'package:tabib_app/features/records/presentation/widgets/record_details_actions.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_error_view.dart';
import 'package:tabib_app/features/records/presentation/widgets/records_loading_view.dart';

class PrescriptionDetailsBody extends StatelessWidget {
  final String prescriptionId;

  const PrescriptionDetailsBody({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return BlocBuilder<PrescriptionDetailsViewModel, PrescriptionDetailsState>(
      builder: (context, state) {
        final detailsState = state.detailsState;
        final details = detailsState.data;
        final apiTitle = details?.localizedScreenTitle(
          context.locale.languageCode,
        );
        final title = (apiTitle == null || apiTitle.isEmpty)
            ? 'records.details.title'.tr()
            : apiTitle;

        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text(title, style: theme.bold18),
            backgroundColor: theme.backgroundColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: theme.textColor600,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: detailsState.isLoading || detailsState.isInitial
              ? const RecordsLoadingView()
              : detailsState.isError || details == null
              ? RecordsErrorView(
                  message: detailsState.errorMessage ?? '',
                  onRetry: () => context
                      .read<PrescriptionDetailsViewModel>()
                      .load(prescriptionId),
                )
              : PrescriptionDetailsContent(details: details),
          bottomSheet: details == null || !details.actions.hasAny
              ? null
              : RecordDetailsActions(actions: details.actions),
        );
      },
    );
  }
}
