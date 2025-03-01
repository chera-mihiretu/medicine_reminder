import 'package:pill_reminder/features/notification/data/models/notification_model.dart';
import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';

class NotificationTestData {
  static final time = DateTime.now().add(const Duration(hours: 1));
  static final NotificationModel notificationModel = NotificationModel(
    id: 1,
    title: 'Medication Reminder',
    body: 'Time to take your medication',
    payload: 'medication_id_123',
    scheduledTime: time,
    imageUrl: null,
    isRecurring: false,
    fullScreen: true,
    sound: 'default',
    channelId: 'medication_channel',
    channelName: 'Medication Reminders',
    priority: MyPriority.high,
    importance: MyImportance.high,
  );

  static final NotificationEntity notificationEntity = NotificationEntity(
    id: 1,
    title: 'Medication Reminder',
    body: 'Time to take your medication',
    payload: 'medication_id_123',
    scheduledTime: time,
    imageUrl: null,
    isRecurring: false,
    fullScreen: true,
    sound: 'default',
    channelId: 'medication_channel',
    channelName: 'Medication Reminders',
    priority: MyPriority.high,
    importance: MyImportance.high,
  );
}
