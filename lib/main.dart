import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/base_state/mybloc_observer.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/initial_app_route.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/tabib_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  final initialAppRoute = await initRouteApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: TabibApp(initialAppRoute: initialAppRoute),
    ),
  );
}

Future<InitialAppRoute> initRouteApp() async {
  final token = await AppLocalStorage.getSecuredString(key: LocalKeys.token);
  log('token: $token');
  if (token.isNotEmpty) {
    final savedRole =
        await AppLocalStorage.getSecuredString(key: LocalKeys.role);
    final role = savedRole.isNotEmpty ? savedRole : 'user';
    CachedUserRole.uiRole = role;
    SocketIoService(token: token).connect();
    return InitialAppRoute(route: AppRoutes.mainLayoutView, role: role);
  }
  return const InitialAppRoute(route: AppRoutes.welcomeView);
}
