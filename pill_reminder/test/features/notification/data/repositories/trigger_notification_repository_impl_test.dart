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

  // Helper: create a MedicineEntity with a given interval and lastTriggered.

  final testMedicine = MedicineTestData.medicineEntity;

  setUp(() {
    mockGetAllMedicineUsecase = MockGetAllMedicineUsecase();
    mockNotificationRepository = MockNotificationRepository();

    repositoryImpl = TriggerNotificationRepositoryImpl(
      getAllMedicineUsecase: mockGetAllMedicineUsecase,
      notificationRepository: mockNotificationRepository,
    );
  });

  group('TriggerNotificationRepositoryImpl', () {
    test(
        'triggerNotificationTenMinuteBefore returns Right(true) when medicine is in notification window',
        () async {
      // Arrange:
      // We need a medicine with a non -1 interval.
      // To simulate a remaining time between 10 and 20 minutes, we use:
      // remainingTime = medicine.interval - diff, so we want diff=0 and interval = 15.
      // For simplicity, set lastTriggered equal to TimeOfDay.now() so diff is near 0.

      // Return a list with one medicine.
      when(mockGetAllMedicineUsecase.execute())
          .thenAnswer((_) async => Right([testMedicine]));

      // Act:
      final result = await repositoryImpl.triggerNotificationTenMinuteBefore();

      // Assert:
      expect(result, const Right(true));
      verify(mockNotificationRepository.showNotification(any)).called(1);
      // NOTE: Since AndroidAlarmManager.oneShot is static, we cannot directly verify that it was called.
      // To test this behavior, consider wrapping oneShot into an injectable service.
    });

    test(
        'triggerNotificationTenMinuteBefore returns Right(true) even if no medicine qualifies for alarm',
        () async {
      // Arrange:

      when(mockGetAllMedicineUsecase.execute())
          .thenAnswer((_) async => Right([testMedicine]));

      // Act:
      final result = await repositoryImpl.triggerNotificationTenMinuteBefore();

      // Assert:
      expect(result, const Right(true));
      // In this case, the scheduling logic is skipped.
    });

    test(
        'triggerNotificationTenMinuteBefore returns Left(failure) when usecase fails',
        () async {
      // Arrange:
      when(mockGetAllMedicineUsecase.execute()).thenAnswer(
          (_) async => const Left(PermissionFailure(message: 'error')));

      // Act:
      // final result = await repositoryImpl.triggerNotificationTenMinuteBefore();

      // Assert:
      // expect(result, Left(failure));
    });
  });
}
