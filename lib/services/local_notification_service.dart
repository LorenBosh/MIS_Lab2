import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    _notificationsPlugin.initialize(initializationSettings);

    tz_data.initializeTimeZones();
  }

  void scheduleDailyNotification() {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('daily_joke_channel', 'Joke of the Day',
        channelDescription: 'Daily joke notification',
        importance: Importance.high,
        priority: Priority.high);

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    _notificationsPlugin.zonedSchedule(
      0,
      'Joke of the Day is ready',
      'Open the app to see today\'s joke!',
      _nextInstanceOfTime(15, 00),
      platformDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

