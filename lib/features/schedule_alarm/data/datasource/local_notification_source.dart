import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationSource {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    final String timeZone = timeZoneInfo.identifier;
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> initialize() async {
    await configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> requestPermissions() async {
    final bool? resultAndroid = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    final bool? resultIOS = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return resultAndroid ?? resultIOS ?? false;
  }

  Future<void> scheduleNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    final now = tz.TZDateTime.now(tz.local);

    for (int i = 0; i < 7; i++) {
      final scheduledDate = now.add(Duration(minutes: i + 1));

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'Scheduled Notification ${i + 1}',
        'This is notification number ${i + 1}',
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'scheduled_channel_id',
            'Scheduled Notifications',
            channelDescription: 'Channel for scheduled notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  Future<void> cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
