import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/data/repositories/notification_repository_impl.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/notification_test_data.dart';

void main() {
  late NotificationRepositoryImpl repository;
  late MockFlutterLocalNotificationsPlugin mockFlutterLocalNotificationsPlugin;
  final notificationTest = NotificationTestData.notificationEntity;
  setUp(() {
    mockFlutterLocalNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
    repository = NotificationRepositoryImpl(
        flutterLocalNotificationsPlugin: mockFlutterLocalNotificationsPlugin);
  });

  group('showNotification', () {
    test('should return true when the notification is shown successfully',
        () async {
      // arrange
      when(mockFlutterLocalNotificationsPlugin.show(
        any,
        any,
        any,
        any,
        payload: anyNamed('payload'),
      )).thenAnswer((_) async => true);

      // act
      final result = await repository.showNotification(notificationTest);

      // assert
      expect(result, const Right(true));
      verify(mockFlutterLocalNotificationsPlugin.show(
        notificationTest.id,
        notificationTest.title,
        notificationTest.body,
        any,
        payload: notificationTest.payload,
      ));
      verifyNoMoreInteractions(mockFlutterLocalNotificationsPlugin);
    });

    test('should return PermissionFailure when an exception occurs', () async {
      // arrange
      when(mockFlutterLocalNotificationsPlugin.show(
        any,
        any,
        any,
        any,
        payload: anyNamed('payload'),
      )).thenThrow(Exception('Permission denied'));

      // act
      final result = await repository.showNotification(notificationTest);

      // assert
      expect(result, isA<Left<Failure, bool>>());
      verify(mockFlutterLocalNotificationsPlugin.show(
        notificationTest.id,
        notificationTest.title,
        notificationTest.body,
        any,
        payload: notificationTest.payload,
      ));
      verifyNoMoreInteractions(mockFlutterLocalNotificationsPlugin);
    });
  });
}
