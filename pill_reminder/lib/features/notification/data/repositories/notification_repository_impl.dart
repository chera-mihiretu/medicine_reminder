import 'dart:developer' as dev;
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationRepositoryImpl({required this.flutterLocalNotificationsPlugin});

  @override
  Future<Either<Failure, bool>> showNotification(
    NotificationEntity notification,
  ) async {
    try {
      // Create notification channel
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        notification.channelId ?? 'default_channel',
        notification.channelName ?? 'Default Channel',
        importance: notification.importance.importance,
        sound: const RawResourceAndroidNotificationSound('default'),
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            notification.channelId ?? 'default_channel',
            notification.channelName ?? 'Default Channel',
            fullScreenIntent: notification.fullScreen,
            importance: notification.importance.importance,
            priority: notification.priority.priority,
            // sound: const RawResourceAndroidNotificationSound('default'),
          );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(),
      );

      await flutterLocalNotificationsPlugin.show(
        (notification.id % pow(10, 9) + 7).toInt(),
        notification.title,
        notification.body,
        notificationDetails,
        payload: notification.payload,
      );
    } catch (e) {
      dev.log(e.toString());
      return Left(PermissionFailure(message: e.toString()));
    }
    return const Right(true);
  }
}
