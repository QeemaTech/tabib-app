import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class RecordsLoadingView extends StatelessWidget {
  const RecordsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.appTheme.primaryColor),
    );
  }
}
