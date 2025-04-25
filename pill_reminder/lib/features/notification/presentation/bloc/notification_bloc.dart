import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_full_screen_notification_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  ShowNotificationUsecase showNotificationUsecase;
  ShowFullScreenNotificationUsecase showFullScreenNotificationUsecase;
  NotificationBloc({
    required this.showNotificationUsecase,
    required this.showFullScreenNotificationUsecase,
  }) : super(NotificationInitialState()) {
    on<ShowNotificationEvent>((event, emit) async {
      emit(NotificationLoadingState());
      final notification = NotificationEntity(
        id: event.id,
        title: event.title,
        body: event.body,
        payload: event.payload,
        scheduledTime: event.scheduledTime,
        imageUrl: event.imageUrl,
        isRecurring: event.isRecurring,
        fullScreen: event.fullScreen,
        sound: event.sound,
        channelId: event.channelId,
        channelName: event.channelName,
        priority: event.priority,
        importance: event.importance,
      );
      final result = await showNotificationUsecase.execute(notification);

      result.fold(
        (failure) => emit(NotificationErrorState(message: failure.message)),
        (success) => emit(NotificationLoadedState()),
      );
    });
    on<ShowFullScreenNotification>((event, emit) async {
      emit(NotificationLoadingState());
      final notification = NotificationEntity(
        id: event.id,
        title: event.title,
        body: event.body,
        payload: event.payload,
        scheduledTime: event.scheduledTime,
        imageUrl: event.imageUrl,
        isRecurring: event.isRecurring,
        fullScreen: event.fullScreen,
        sound: event.sound,
        channelId: event.channelId,
        channelName: event.channelName,
        priority: event.priority,
        importance: event.importance,
      );

      final result = await showFullScreenNotificationUsecase.execute(
        notification,
      );

      result.fold(
        (failure) => emit(NotificationErrorState(message: failure.message)),
        (success) => emit(NotificationLoadedState()),
      );
    });
  }
}
