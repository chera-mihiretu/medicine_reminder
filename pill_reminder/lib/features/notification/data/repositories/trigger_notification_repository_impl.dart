import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';

class TriggerNotificationRepositoryImpl extends TriggerNotificationRepository {
  GetAllMedicineUsecase getAllMedicineUsecase;
  NotificationRepository notificationRepository;
  TriggerNotificationRepositoryImpl({
    required this.getAllMedicineUsecase,
    required this.notificationRepository,
  });

  @override
  Future<Either<Failure, bool>> triggerNotification() async {
    final result = await getAllMedicineUsecase.execute();
    return result.fold((failure) => Left(failure), (medicines) async {
      final currentTime = TimeOfDay.now();
      final nowInMinutes = currentTime.hour * 60 + currentTime.minute;

      for (MedicineEntity medicine in medicines) {
        if (medicine.interval != null) {
          TimeOfDay last = medicine.lastTriggered;
          final lastInMinutes = last.hour * 60 + last.minute;
          final diff = nowInMinutes - lastInMinutes;
          final remainingTime = medicine.interval! - diff;
          if (remainingTime > 0 && remainingTime <= 10) {
            NotificationEntity notification = NotificationEntity(
              id: DateTime.now().millisecondsSinceEpoch,
              title: 'Don\'t Forget Your Medicine',
              body: 'Time to take ${medicine.name}',
              payload: medicine.medicineId,
              scheduledTime: DateTime.now(),
              imageUrl: '',
              isRecurring: false,
              fullScreen: true,
              sound: 'default',
              channelId: 'reminder',
              channelName: 'Reminder',
              priority: MyPriority.high,
              importance: MyImportance.high,
            );
            AndroidAlarmManager.oneShot(
              Duration(minutes: remainingTime),
              DateTime.now().millisecondsSinceEpoch,
              () async =>
                  await notificationRepository.showNotification(notification),
            );
          }
        } else {
          for (var time in medicine.time!) {
            final scheduledMinutes = time.hour * 60 + time.minute;
            int difference = scheduledMinutes - nowInMinutes;
            if (difference <= 10) {
              NotificationEntity notification = NotificationEntity(
                id: DateTime.now().millisecondsSinceEpoch,
                title: 'Don\'t Forget Your Medicine',
                body: 'Time to take ${medicine.name}',
                payload: medicine.medicineId,
                scheduledTime: DateTime.now(),
                imageUrl: '',
                isRecurring: false,
                fullScreen: true,
                sound: 'default',
                channelId: 'reminder',
                channelName: 'Reminder',
                priority: MyPriority.high,
                importance: MyImportance.high,
              );
              AndroidAlarmManager.oneShot(
                Duration(minutes: difference),
                DateTime.now().millisecondsSinceEpoch,
                () async =>
                    await notificationRepository.showNotification(notification),
              );
            }
          }
        }
      }
      return const Right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> triggerNotificationTenMinuteBefore() async {
    final result = await getAllMedicineUsecase.execute();
    return result.fold((failure) => Left(failure), (medicines) async {
      final currentTime = TimeOfDay.now();
      final nowInMinutes = currentTime.hour * 60 + currentTime.minute;

      for (MedicineEntity medicine in medicines) {
        if (medicine.interval != null) {
          TimeOfDay last = medicine.lastTriggered;
          final lastInMinutes = last.hour * 60 + last.minute;
          final diff = nowInMinutes - lastInMinutes;
          final remainingTime = medicine.interval! - diff;
          if (remainingTime > 0 && remainingTime >= 10 && remainingTime <= 20) {
            NotificationEntity notification = NotificationEntity(
              id: DateTime.now().millisecondsSinceEpoch,
              title: 'Don\'t Forget Your Medicine',
              body: 'Time to take ${medicine.name}',
              payload: medicine.medicineId,
              scheduledTime: DateTime.now(),
              imageUrl: '',
              isRecurring: false,
              fullScreen: false,
              sound: 'default',
              channelId: 'reminder',
              channelName: 'Reminder',
              priority: MyPriority.high,
              importance: MyImportance.high,
            );
            AndroidAlarmManager.oneShot(
              Duration(minutes: remainingTime - 10),
              DateTime.now().millisecondsSinceEpoch,
              () async =>
                  await notificationRepository.showNotification(notification),
            );
          }
        } else {
          for (var time in medicine.time!) {
            final scheduledMinutes = time.hour * 60 + time.minute;
            int difference = scheduledMinutes - nowInMinutes;
            if (difference < 20 && difference > 10) {
              NotificationEntity notification = NotificationEntity(
                id: DateTime.now().millisecondsSinceEpoch,
                title: 'Don\'t Forget Your Medicine',
                body: 'Time to take ${medicine.name}',
                payload: medicine.medicineId,
                scheduledTime: DateTime.now(),
                imageUrl: '',
                isRecurring: false,
                fullScreen: false,
                sound: 'default',
                channelId: 'reminder',
                channelName: 'Reminder',
                priority: MyPriority.high,
                importance: MyImportance.high,
              );
              AndroidAlarmManager.oneShot(
                Duration(minutes: difference - 10),
                DateTime.now().millisecondsSinceEpoch,
                () async =>
                    await notificationRepository.showNotification(notification),
              );
            }
          }
        }
      }
      return const Right(true);
    });
  }
}
