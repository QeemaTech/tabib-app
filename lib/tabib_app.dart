import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/routes/app_routes.dart';
import 'package:tabib_app/core/theme/app_theme/light_theme.dart';

class TabibApp extends StatelessWidget {
  const TabibApp({super.key, required this.initialRoute});

  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'appTitle'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute:initialRoute,
      theme: LightTheme().themeData,
    );
  }
}
