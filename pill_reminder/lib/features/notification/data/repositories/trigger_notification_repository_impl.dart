import 'dart:math';
import 'dart:developer' as dev;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/notification/data/models/notification_model.dart';
import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';

class TriggerNotificationRepositoryImpl extends TriggerNotificationRepository {
  GetAllMedicineUsecase getAllMedicineUsecase;
  NotificationRepository notificationRepository;
  MedicineLocalDataSource medicineLocalDataSource;
  TriggerNotificationRepositoryImpl({
    required this.getAllMedicineUsecase,
    required this.notificationRepository,
    required this.medicineLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> scheduleNotification() async {
    final result = await getAllMedicineUsecase.execute();
    return result.fold((failure) => Left(failure), (medicines) async {
      for (MedicineEntity medicine in medicines) {
        if (medicine.time != null && medicine.time!.isNotEmpty) {
          for (TimeOfDay time in medicine.time!) {
            DateTime actualSchedule = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              time.hour,
              time.minute,
            );

            DateTime prevSchedule = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              medicine.lastTriggered.hour,
              medicine.lastTriggered.minute,
            );

            bool flag = false;

            while (!compareLessSpecific(actualSchedule)) {
              flag = true;
              int year = actualSchedule.year;
              int month = actualSchedule.month;
              int day = actualSchedule.day;

              day = day + 1;
              month = month + (day ~/ 30);
              day = day % 30;
              year = year + (month ~/ 12);
              month = month % 12;
              prevSchedule = actualSchedule;
              actualSchedule = DateTime(
                year,
                month,
                day,
                time.hour,
                time.minute,
              );
            }
            if (flag) await updateCurrentMedicine(medicine, prevSchedule);

            int id =
                int.parse('${medicine.medicineId}${time.hour}${time.minute}') %
                (pow(10, 9).toInt() + 7);

            notificationSchedule(medicine, id, actualSchedule);
          }
        } else {
          int minutes = (((0.02 - (0.02 ~/ 1))) * 60) ~/ 1;
          final scheduleTime = TimeOfDay(
            hour: medicine.lastTriggered.hour + (medicine.interval! ~/ 1),
            minute: medicine.lastTriggered.minute + minutes,
          );
          DateTime prevSchedule = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            medicine.lastTriggered.hour,
            medicine.lastTriggered.minute,
          );
          DateTime actualSchedule = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            scheduleTime.hour,
            scheduleTime.minute,
          );
          bool flag = false;
          while (!compareLess(actualSchedule)) {
            flag = true;
            int year = actualSchedule.year;
            int month = actualSchedule.month;
            int day = actualSchedule.day;
            int hour = actualSchedule.hour;
            int minute = actualSchedule.minute;
            minute = minute + (minutes);
            hour = hour + (medicine.interval! ~/ 1) + (minute ~/ 60);
            minute = minute % 60;
            day = day + (hour ~/ 24);
            hour = hour % 24;
            month = month + (day ~/ 30);
            day = day % 30;
            year = year + (month ~/ 12);
            month = month % 12;

            prevSchedule = actualSchedule;
            actualSchedule = DateTime(year, month, day, hour, minute);
            dev.log('Next Schedule ${actualSchedule.toString()}');
          }
          if (flag) await updateCurrentMedicine(medicine, prevSchedule);

          dev.log('Scheduling For ${actualSchedule.toString()}');
          int id =
              int.parse(
                '${medicine.medicineId}${scheduleTime.hour}${scheduleTime.minute}',
              ) %
              (pow(10, 9).toInt() + 7);
          notificationSchedule(medicine, id, actualSchedule);
        }
      }

      return const Right(true);
    });
  }

  bool compareLess(DateTime schedule) {
    DateTime now = DateTime.now();
    return schedule.year <= now.year &&
        schedule.day <= now.day &&
        schedule.hour <= now.hour &&
        schedule.minute > now.minute;
  }

  bool compareLessSpecific(DateTime schedule) {
    DateTime now = DateTime.now();
    return (schedule.year <= now.year &&
        schedule.day <= now.day &&
        schedule.hour <= now.hour);
  }

  Future<bool> updateCurrentMedicine(
    MedicineEntity medicine,
    DateTime schedule,
  ) async {
    return await medicineLocalDataSource.updateMedicine(
      MedicineModel(
        medicineId: medicine.medicineId,
        name: medicine.name,
        interval: medicine.interval,
        startDate: medicine.startDate,
        medicineAmount: medicine.medicineAmount,
        medicineTaken: medicine.medicineTaken,
        lastTriggered: TimeOfDay(hour: schedule.hour, minute: schedule.minute),
      ),
    );
  }

  void notificationSchedule(
    MedicineEntity medicine,
    int id,
    DateTime actualSchedule,
  ) {
    notificationRepository.scheduleNotification(
      NotificationModel(
        id: id,
        title: 'It is time take your medicine: ${medicine.name}',
        body:
            'You have taken ${medicine.medicineTaken.toString()} out of ${medicine.medicineAmount.toString()} dont forget to take it, Click the below button if you have taken it',
        payload:
            '${medicine.medicineId}:${actualSchedule.hour}:${actualSchedule.minute}',
        scheduledTime: actualSchedule,
        isRecurring: true,
        priority: MyPriority.high,
        importance: MyImportance.high,
        fullScreen: true,
      ),
    );
  }
}
