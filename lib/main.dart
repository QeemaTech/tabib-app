import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabib_app/core/base_state/mybloc_observer.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/di/di.dart';
import 'package:tabib_app/core/routes/routes.dart';
import 'package:tabib_app/tabib_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  final route = await initRouteApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: TabibApp(initialRoute: route),
    ),
  );
}


Future<String>initRouteApp()async{
  final token = await AppLocalStorage.getSecuredString(key: LocalKeys.token);
  if(token.isNotEmpty){
    return AppRoutes.mainLayoutView;
  }
  return AppRoutes.welcomeView;
}