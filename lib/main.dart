import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/base_state/mybloc_observer.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/cached_user_role.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/initial_app_route.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/core/services/fcm_service.dart';
import 'package:tabib_app/core/services/local_notification_service.dart';
import 'package:tabib_app/features/auth/domain/repo/auth_repo.dart';
import 'package:tabib_app/tabib_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();

  unawaited(() async {
    await FcmService.requestNotificationPermission();
    await Future.wait([
      FcmService.currentToken(),
      LocalNotificationService.initLocalNotification(),
    ]);
  }());
  FcmService.listenForTokenRefresh((token) async {
    if (token.isEmpty) {
      return;
    }
    final accessToken = await AppLocalStorage.getSecuredString(
      key: LocalKeys.token,
    );
    if (accessToken.isEmpty) {
      return;
    }
    await getIt<AuthRepo>().registerDevice();
  });

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
  if (token.isNotEmpty) {
    final savedRole =
        await AppLocalStorage.getSecuredString(key: LocalKeys.role);
    final role = savedRole.isNotEmpty ? savedRole : 'user';
    CachedUserRole.uiRole = role;
    return InitialAppRoute(route: AppRoutes.mainLayoutView, role: role);
  }
  return const InitialAppRoute(route: AppRoutes.welcomeView);
}
