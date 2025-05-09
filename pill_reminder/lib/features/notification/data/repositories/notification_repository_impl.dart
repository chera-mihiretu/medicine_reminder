import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationRepositoryImpl({required this.flutterLocalNotificationsPlugin}) {
    tz_data.initializeTimeZones();
  }

  @override
  Future<Either<Failure, bool>> scheduleNotification(
    NotificationEntity notification,
  ) async {
    try {
      final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
        notification.scheduledTime,
        tz.local,
      );

      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            notification.channelId ?? 'scheduled_channel',
            notification.channelName ?? 'Medicine Reminder',
            channelDescription: 'Do Not forget to take your medicine',
            importance: notification.importance.importance,
            priority: notification.priority.priority,
            fullScreenIntent: notification.fullScreen,
            actions: [
              const AndroidNotificationAction(
                'take_medicine',
                'Taken',
                cancelNotification: true,
                showsUserInterface: true,
              ),
            ],
          );

      final DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
            categoryIdentifier: 'alarm_category',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        scheduledDate,
        notificationDetails,
        payload: notification.payload,

        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      return Left(PermissionFailure(message: e.toString()));
    }
    return const Right(true);
  }
}
