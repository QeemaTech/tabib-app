import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// stream Controller

final StreamController<NotificationResponse> _streamController =
    StreamController();

StreamController get notificationStream => _streamController;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse event) {
  _streamController.add(event);
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static final _largeIcon = "@mipmap/ic_launcher";
  // static final _soundNotification = "sound_notification";
  // static final _soundSettings = RawResourceAndroidNotificationSound(
  //   _soundNotification,
    
  // );
  static final _channelId = "default_notification";
  static final _channelName = "notification";

  static Future<void> initLocalNotification() async {
    final androidSetting = AndroidInitializationSettings(_largeIcon);
    const iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final settings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting,
    );

    _plugin.initialize(
      settings: settings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

      // await _plugin
      //     .resolvePlatformSpecificImplementation<
      //       AndroidFlutterLocalNotificationsPlugin
      //     >()
      //     ?.createNotificationChannel(
      //       AndroidNotificationChannel(
      //         _channelId,
      //         _channelName,
      //         sound: _soundSettings,
      //         importance: Importance.max,
      //         playSound: true,
      //       ),
      //     );
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: "channel notifications",
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap(_largeIcon),
      //sound: RawResourceAndroidNotificationSound(_soundNotification),
      enableVibration: true,
      playSound: true,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    //sound: '$_soundNotification.wav', // في iOS يجب كتابة الامتداد (مثل .wav أو .mp3)
    );

    await _plugin.show(
      id: DateTime.timestamp().millisecond,
      title: title,
      body: body,
      payload: "payload data test ",

      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
    );
  }
}
