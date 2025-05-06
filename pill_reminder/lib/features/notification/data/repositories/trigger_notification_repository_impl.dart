import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
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
          // MedicineModel newMed = MedicineModel(
          //   medicineId: medicine.medicineId,
          //   name: medicine.name,
          //   startDate: medicine.startDate,
          //   medicineAmount: medicine.medicineAmount,
          //   medicineTaken: medicine.medicineTaken,
          //   lastTriggered: medicine.lastTriggered,
          //   scheduled: true,
          // );

          // medicineLocalDataSource.updateMedicine(newMed);
          for (TimeOfDay time in medicine.time!) {
            int id =
                int.parse('${medicine.medicineId}${time.hour}${time.minute}') %
                (pow(10, 9).toInt() + 7);
            notificationRepository.scheduleNotification(
              NotificationModel(
                id: id,
                title: 'It is time take your medicine: ${medicine.name}',
                body:
                    'You have taken ${medicine.medicineTaken.toString()} out of ${medicine.medicineAmount.toString()} dont forget to take it, Click the below button if you have taken it',
                payload: '${medicine.medicineId}:${time.hour}:${time.minute}',
                scheduledTime: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  //! This is for debugging purposes
                  DateTime.now().hour,
                  DateTime.now().minute,
                  DateTime.now().second + 10,
                  // time.hour,
                  // time.minute,
                ),
                isRecurring: true,
                priority: MyPriority.high,
                importance: MyImportance.high,
                fullScreen: true,
              ),
            );
          }
          // TODO : Schedule for recurring notifications
        } else {}
      }

      return const Right(true);
    });
  }
}
