import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/features/notification/domain/usecases/schedule_notification_usecase.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  ScheduleNotificationUsecase scheduleNotificationUsecase;
  NotificationBloc({required this.scheduleNotificationUsecase})
    : super(NotificationInitialState()) {
    on<ScheduleNotificationEvent>((event, emit) async {
      emit(NotificationLoadingState());
      final result = await scheduleNotificationUsecase.execute();

      result.fold((failure) {
        emit(NotificationErrorState(message: failure.message));
      }, (success) => emit(NotificationLoadedState()));
    });
  }
}
