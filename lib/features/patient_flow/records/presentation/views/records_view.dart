import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/view_model/records_view_model.dart';
import 'package:tabib_app/features/patient_flow/records/presentation/widgets/records_view_body.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecordsViewModel>()..load(),
      child: const RecordsViewBody(),
    );
  }
}
