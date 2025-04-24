import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';

class NotificationCallback {
  Future<void> showNotification(NotificationEntity notification) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final notificationRepository = NotificationRepositoryImpl(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
    );
    await notificationRepository.showNotification(notification);
  }
}

// Keep the original function for backward compatibility
Future<void> showNotificationCallback(NotificationEntity notification) async {
  final callback = NotificationCallback();
  await callback.showNotification(notification);
}
