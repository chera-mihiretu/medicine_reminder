import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/data/repositories/trigger_notification_repository_impl.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

// NOTE:
// AndroidAlarmManager.oneShot is a static method which cannot be mocked directly.
// For better testability, consider wrapping it in an injectable class.
// In these tests we verify that triggerNotificationTenMinuteBefore returns Right(true)
// when the conditions are met.
// To test that oneShot is called, you may wrap its call into a callback parameter or a service.

void main() {
  late TriggerNotificationRepositoryImpl repositoryImpl;
  late MockGetAllMedicineUsecase mockGetAllMedicineUsecase;
  late MockNotificationRepository mockNotificationRepository;
  late MockMedicineLocalDataSource mockMedicineLocalDataSource;

  // Helper: create a MedicineEntity with a given interval and lastTriggered.

  final testMedicine = MedicineTestData.medicineEntityWithInterval;

  setUp(() {
    mockGetAllMedicineUsecase = MockGetAllMedicineUsecase();
    mockNotificationRepository = MockNotificationRepository();
    mockMedicineLocalDataSource = MockMedicineLocalDataSource();

    repositoryImpl = TriggerNotificationRepositoryImpl(
      getAllMedicineUsecase: mockGetAllMedicineUsecase,
      notificationRepository: mockNotificationRepository,
      medicineLocalDataSource: mockMedicineLocalDataSource,
    );
  });

  group('TriggerNotificationRepositoryImpl', () {
    test(
      'scheduleNotification returns Right(true) when notifications are scheduled successfully',
      () async {
        // Arrange
        when(
          mockGetAllMedicineUsecase.execute(),
        ).thenAnswer((_) async => Right([testMedicine]));
        when(
          mockNotificationRepository.scheduleNotification(any),
        ).thenAnswer((_) async => const Right(true));
        when(
          mockMedicineLocalDataSource.updateMedicine(any),
        ).thenAnswer((_) async => true);

        // Act
        final result = await repositoryImpl.scheduleNotification();

        // Assert
        expect(result, const Right(true));
        verify(mockNotificationRepository.scheduleNotification(any)).called(1);
      },
    );

    test(
      'scheduleNotification returns Right(true) when no medicines need scheduling',
      () async {
        // Arrange
        when(
          mockGetAllMedicineUsecase.execute(),
        ).thenAnswer((_) async => const Right([]));

        // Act
        final result = await repositoryImpl.scheduleNotification();

        // Assert
        expect(result, const Right(true));
        verifyNever(mockNotificationRepository.scheduleNotification(any));
      },
    );

    test(
      'scheduleNotification returns Left(failure) when usecase fails',
      () async {
        // Arrange
        when(mockGetAllMedicineUsecase.execute()).thenAnswer(
          (_) async => const Left(PermissionFailure(message: 'error')),
        );

        // Act
        final result = await repositoryImpl.scheduleNotification();

        // Assert
        expect(result, const Left(PermissionFailure(message: 'error')));
        verifyNever(mockNotificationRepository.scheduleNotification(any));
        verifyNever(mockMedicineLocalDataSource.updateMedicine(any));
      },
    );
  });
}
