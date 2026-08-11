import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
  }

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await plugin.initialize( settings: settings);
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  Future<void> requestPermission() async {
    await _android?.requestNotificationsPermission();

    // Android 14+ denies SCHEDULE_EXACT_ALARM by default; this opens the
    // "Alarms & reminders" settings screen so the user can grant it.
    if (await _android?.canScheduleExactNotifications() == false) {
      await _android?.requestExactAlarmsPermission();
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        channelDescription: 'Reminder notifications for tasks',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final canBeExact = await _android?.canScheduleExactNotifications() ?? true;

    await plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(seconds: 10)),
      notificationDetails: notificationDetails(),
      androidScheduleMode: canBeExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }
}
