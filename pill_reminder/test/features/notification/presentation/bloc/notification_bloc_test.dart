import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_state.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_full_screen_notification_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../test_data/notification_test_data.dart';

class MockShowNotificationUsecase extends Mock
    implements ShowNotificationUsecase {}

class MockShowFullScreenNotificationUsecase extends Mock
    implements ShowFullScreenNotificationUsecase {}

void main() {
  late NotificationBloc notificationBloc;
  late MockShowNotificationUsecase mockShowNotificationUsecase;
  late MockShowFullScreenNotificationUsecase
      mockShowFullScreenNotificationUsecase;
  final notification = NotificationTestData.notificationModel;
  const testError = "Error";

  setUp(() {
    mockShowNotificationUsecase = MockShowNotificationUsecase();
    mockShowFullScreenNotificationUsecase =
        MockShowFullScreenNotificationUsecase();
    notificationBloc = NotificationBloc(
        mockShowNotificationUsecase, mockShowFullScreenNotificationUsecase);
  });

  group('NotificationBloc', () {
    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationLoadedState] when ShowNotifaicationEvent is added and usecase succeeds',
      build: () {
        when(mockShowNotificationUsecase.execute(notification))
            .thenAnswer((_) async => const Right(true));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ShowNotifaicationEvent(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
        scheduledTime: notification.scheduledTime,
        imageUrl: notification.imageUrl,
        isRecurring: notification.isRecurring,
        sound: notification.sound,
        channelId: notification.channelId,
        channelName: notification.channelName,
        priority: notification.priority,
        importance: notification.importance,
      )),
      expect: () => [
        NotificationLoadingState(),
        NotificationLoadedState(),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationErrorState] when ShowNotifaicationEvent is added and usecase fails',
      build: () {
        when(mockShowNotificationUsecase.execute(notification)).thenAnswer(
            (_) async => const Left(PermissionFailure(message: testError)));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ShowNotifaicationEvent(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
        scheduledTime: notification.scheduledTime,
        imageUrl: notification.imageUrl,
        isRecurring: notification.isRecurring,
        sound: notification.sound,
        channelId: notification.channelId,
        channelName: notification.channelName,
        priority: notification.priority,
        importance: notification.importance,
      )),
      expect: () => [
        NotificationLoadingState(),
        NotificationErrorState(message: 'Error'),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationLoadedState] when ShowFullScreenNotification is added and usecase succeeds',
      build: () {
        when(mockShowFullScreenNotificationUsecase.execute(notification))
            .thenAnswer((_) async => const Right(true));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ShowFullScreenNotification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
        scheduledTime: notification.scheduledTime,
        imageUrl: notification.imageUrl,
        isRecurring: notification.isRecurring,
        sound: notification.sound,
        channelId: notification.channelId,
        channelName: notification.channelName,
        priority: notification.priority,
        importance: notification.importance,
      )),
      expect: () => [
        NotificationLoadingState(),
        NotificationLoadedState(),
      ],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationErrorState] when ShowFullScreenNotification is added and usecase fails',
      build: () {
        when(mockShowFullScreenNotificationUsecase.execute(notification))
            .thenAnswer(
                (_) async => const Left(PermissionFailure(message: testError)));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ShowFullScreenNotification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: notification.payload,
        scheduledTime: notification.scheduledTime,
        imageUrl: notification.imageUrl,
        isRecurring: notification.isRecurring,
        sound: notification.sound,
        channelId: notification.channelId,
        channelName: notification.channelName,
        priority: notification.priority,
        importance: notification.importance,
      )),
      expect: () => [
        NotificationLoadingState(),
        NotificationErrorState(message: 'Error'),
      ],
    );
  });
}
