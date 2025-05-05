import 'package:equatable/equatable.dart';
import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final String payload;
  final DateTime scheduledTime;
  final String? imageUrl;
  final bool isRecurring;
  final bool fullScreen;
  final String? sound;
  final String? channelId;
  final String? channelName;
  final MyPriority priority;
  final MyImportance importance;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.scheduledTime,
    this.imageUrl,
    required this.fullScreen,
    required this.isRecurring,
    this.sound,
    this.channelId,
    this.channelName,
    required this.priority,
    required this.importance,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    body,
    payload,
    scheduledTime,
    imageUrl,
    isRecurring,
    fullScreen,
    sound,
    channelId,
    channelName,
    priority,
    importance,
  ];
}
