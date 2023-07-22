import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification {
  final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  // Store the scheduled product IDs in a Set to avoid duplicates
  final Set<int> _scheduledProductIds = {};

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings settings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notification.initialize(settings);
    tz.initializeTimeZones();
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );

    return const NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _notification.show(id, title, body, details);
    // Remove the product ID from the set after showing the notification
    _scheduledProductIds.remove(id);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
  }) async {
    // Check if the product ID is already scheduled
    if (_scheduledProductIds.contains(id)) {
      return; // Return early if already scheduled
    }

    // Add the product ID to the set of scheduled IDs
    _scheduledProductIds.add(id);
    final details = await _notificationDetails();
    await _notification.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<tz.TZDateTime> _nextInstanceOfTime(
      int hour, int minute, tz.Location timeZone) async {
    final tz.TZDateTime now = tz.TZDateTime.now(timeZone);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      timeZone,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> scheduleNotificationOneDayBeforeExpiry({
    required int id,
    required String title,
    required String body,
    required DateTime expiryDate,
    required String timeZoneIdentifier,
  }) async {
    // Initialize time zones
    final tz.Location timeZone = tz.getLocation(timeZoneIdentifier);
    final tz.TZDateTime expiryDateTime =
        tz.TZDateTime.from(expiryDate, timeZone);

    final now = tz.TZDateTime.now(timeZone);

    final message = 'The product is about to expire';

    if (expiryDateTime.isAfter(now) && !_scheduledProductIds.contains(id)) {
      final tz.TZDateTime scheduledTime = tz.TZDateTime(
        timeZone,
        expiryDateTime.year,
        expiryDateTime.month,
        expiryDateTime.day,
        14,
        08,
      ).subtract(const Duration(days: 1));

      // Schedule the initial notification one day before the expiry date
      await scheduleNotification(
        id: id,
        title: title,
        body: '$message\n$body',
        scheduledDate: scheduledTime,
      );
    }
  }
}
