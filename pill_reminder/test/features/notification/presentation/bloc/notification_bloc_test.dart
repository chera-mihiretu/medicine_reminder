import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_state.dart';
import 'package:dartz/dartz.dart';
import 'package:timezone/data/latest.dart' as tz_data;

import '../../../../mock/mock_generator.mocks.dart';

void main() {
  late NotificationBloc notificationBloc;
  late MockScheduleNotificationUsecase mockScheduleNotificationUsecase;
  const testError = "Error";

  setUpAll(() {
    tz_data.initializeTimeZones();
  });

  setUp(() {
    mockScheduleNotificationUsecase = MockScheduleNotificationUsecase();
    notificationBloc = NotificationBloc(
      scheduleNotificationUsecase: mockScheduleNotificationUsecase,
    );
  });

  group('NotificationBloc', () {
    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationLoadedState] when ScheduleNotificationEvent is added and usecase succeeds',
      build: () {
        when(
          mockScheduleNotificationUsecase.execute(),
        ).thenAnswer((_) async => const Right(null));
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ScheduleNotificationEvent()),
      expect: () => [NotificationLoadingState(), NotificationLoadedState()],
    );

    blocTest<NotificationBloc, NotificationState>(
      'emits [NotificationLoadingState, NotificationErrorState] when ScheduleNotificationEvent is added and usecase fails',
      build: () {
        when(mockScheduleNotificationUsecase.execute()).thenAnswer(
          (_) async => const Left(PermissionFailure(message: testError)),
        );
        return notificationBloc;
      },
      act: (bloc) => bloc.add(ScheduleNotificationEvent()),
      expect:
          () => [
            NotificationLoadingState(),
            NotificationErrorState(message: 'Error'),
          ],
    );
  });
}
