sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState({required this.message});
}
