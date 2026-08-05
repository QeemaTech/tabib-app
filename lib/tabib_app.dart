import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tabib_app/core/routes/app_routes.dart';
import 'package:tabib_app/core/routes/initial_app_route.dart';
import 'package:tabib_app/core/theme/app_theme/light_theme.dart';

class TabibApp extends StatelessWidget {
  const TabibApp({super.key, required this.initialAppRoute});

  final InitialAppRoute initialAppRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'appTitle'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: initialAppRoute.route,
      onGenerateInitialRoutes: (_) {
        final route = Routes.onGenerateRoute(
          RouteSettings(
            name: initialAppRoute.route,
            arguments: initialAppRoute.role,
          ),
        );
        return [?route];
      },
      theme: LightTheme().themeData,
    );
  }
}
