import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';

sealed class NotificationEvent {}

class ShowNotificationEvent extends NotificationEvent {
  final int id;
  final String title;
  final String body;
  final String payload;
  final DateTime scheduledTime;
  final String? imageUrl;
  final bool isRecurring;
  final bool fullScreen = false;
  final String? sound;
  final String? channelId;
  final String? channelName;
  final MyPriority priority;
  final MyImportance importance;

  ShowNotificationEvent({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.scheduledTime,
    this.imageUrl,
    required this.isRecurring,
    this.sound,
    this.channelId,
    this.channelName,
    required this.priority,
    required this.importance,
  });
}

class ShowFullScreenNotification extends NotificationEvent {
  final int id;
  final String title;
  final String body;
  final String payload;
  final DateTime scheduledTime;
  final bool fullScreen = true;
  final String? imageUrl;
  final bool isRecurring;
  final String? sound;
  final String? channelId;
  final String? channelName;
  final MyPriority priority;
  final MyImportance importance;

  ShowFullScreenNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.scheduledTime,
    this.imageUrl,
    required this.isRecurring,
    this.sound,
    this.channelId,
    this.channelName,
    required this.priority,
    required this.importance,
  });
}
