import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationRepositoryImpl({required this.flutterLocalNotificationsPlugin}) {
    AndroidInitializationSettings _ =
        const AndroidInitializationSettings('app_icon');
  }

  @override
  Future<Either<Failure, bool>> showNotification(
      NotificationEntity notification) async {
    try {
      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        notification.channelId!,
        notification.channelName!,
        fullScreenIntent: true,
        importance: notification.importance.importance,
        priority: notification.priority.priority,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        notificationDetails,
        payload: notification.payload,
      );
    } catch (e) {
      return Left(PermissionFailure(message: e.toString()));
    }
    return const Right(true);
  }
}
