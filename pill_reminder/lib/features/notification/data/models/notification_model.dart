import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.payload,
    required super.scheduledTime,
    super.imageUrl,
    required super.isRecurring,
    super.sound,
    super.channelId,
    super.channelName,
    required super.priority,
    required super.importance,
    required super.fullScreen,
  });

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
      scheduledTime: entity.scheduledTime,
      imageUrl: entity.imageUrl,
      isRecurring: entity.isRecurring,
      sound: entity.sound,
      channelId: entity.channelId,
      channelName: entity.channelName,
      priority: entity.priority,
      importance: entity.importance,
      fullScreen: entity.fullScreen,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      payload: payload,
      scheduledTime: scheduledTime,
      imageUrl: imageUrl,
      isRecurring: isRecurring,
      sound: sound,
      channelId: channelId,
      channelName: channelName,
      priority: priority,
      importance: importance,
      fullScreen: fullScreen,
    );
  }
}
