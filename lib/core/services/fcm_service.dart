import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/services/local_notification_service.dart';

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static String get platform => Platform.isIOS ? 'IOS' : 'ANDROID';

  static Future<String?> currentToken() async {
    final fcmToken = await _messaging.getToken();
    log(fcmToken ?? 'FCM TOKEN NOT AVAILABLE', name: 'fcmToken');
    await _persistToken(fcmToken);
    return fcmToken;
  }

  static Future<String?> cachedToken() async {
    final stored = await AppLocalStorage.getString(key: LocalKeys.fcmToken);
    if (stored.isEmpty) {
      return null;
    }
    return stored;
  }

  static Future<void> requestNotificationPermission() async {
    final permission = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    log(
      permission.authorizationStatus.toString(),
      name: 'NotificationPermission',
    );

    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      log(status.toString(), name: 'AndroidNotificationPermission');
    }
  }

  static void listenForTokenRefresh(
    Future<void> Function(String token) onToken,
  ) {
    _messaging.onRegistered.listen((token) async {
      await _persistToken(token);
      await onToken(token);
    });
  }

  static Future<void> _persistToken(String? fcmToken) async {
    if (fcmToken == null || fcmToken.isEmpty) {
      return;
    }
    await AppLocalStorage.setData(key: LocalKeys.fcmToken, value: fcmToken);
  }

  static Future<void> initFcmService() async {
    await requestNotificationPermission();

    if (Platform.isIOS) {
      String? apnsToken;
      int retries = 0;

      while (apnsToken == null && retries < 5) {
        apnsToken = await _messaging.getAPNSToken();

        if (apnsToken == null) {
          await Future.delayed(const Duration(seconds: 2));
        }

        retries++;
      }

      log(apnsToken ?? 'APNS TOKEN NOT AVAILABLE', name: 'apnsToken');
    }

    final fcmToken = await currentToken();

    if (fcmToken != null) {
      log(fcmToken, name: 'fcmToken');
    }

    await _messaging.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;

      if (!await _isNotificationPermissionGranted) {
        return;
      }

      if (title != null && body != null) {
        await LocalNotificationService.showLocalNotification(
          title: title,
          body: body,
        );
      }
    });
  }

  static Future<bool> get _isNotificationPermissionGranted async {
    return (await Permission.notification.status).isGranted;
  }
}
