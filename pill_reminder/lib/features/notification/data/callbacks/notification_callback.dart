import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/injection.dart';

class NotificationCallback {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final NotificationRepository notificationRepository;

  NotificationCallback({
    required this.flutterLocalNotificationsPlugin,
    required this.notificationRepository,
  });

  Future<void> showNotification(NotificationEntity notification) async {
    await notificationRepository.showNotification(notification);
  }
}

// Keep the original function for backward compatibility
Future<void> showNotificationCallback(NotificationEntity notification) async {
  final callback = NotificationCallback(
    flutterLocalNotificationsPlugin: locator<FlutterLocalNotificationsPlugin>(),
    notificationRepository: locator<NotificationRepository>(),
  );
  await callback.showNotification(notification);
}
