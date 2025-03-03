import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_reminder/cores/constants/app_data.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/features/medicine/data/repositories/medicine_repository_impl.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_madicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:pill_reminder/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:pill_reminder/features/notification/data/repositories/trigger_notification_repository_impl.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_full_screen_notification_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/trigger_notification_ten_minute_before_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/trigger_notification_usecase.dart';
import 'package:workmanager/workmanager.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Hive Registration

  await Hive.initFlutter();

  Hive.registerAdapter(MedicineModelAdapter());

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final medicineBox = await Hive.openBox<MedicineModel>(AppData.medicineBox);
  locator.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => flutterLocalNotificationsPlugin);
  locator.registerLazySingleton<Box<MedicineModel>>(() => medicineBox);

  // Repository Registration

  locator.registerLazySingleton<MedicineRepository>(
      () => MedicineRepositoryImpl(localDataSource: locator()));
  locator.registerLazySingleton<NotificationRepository>(() =>
      NotificationRepositoryImpl(flutterLocalNotificationsPlugin: locator()));
  locator.registerLazySingleton<TriggerNotificationRepository>(() =>
      TriggerNotificationRepositoryImpl(
          getAllMedicineUsecase: locator(), notificationRepository: locator()));

  // Usecase Registration
  locator.registerLazySingleton(() => AddMedicineUsecase(locator()));
  locator.registerLazySingleton(() => UpdateMedicineUsecase(locator()));
  locator.registerLazySingleton(() => DeleteMedicineUsecase(locator()));
  locator.registerLazySingleton(() => GetAllMedicineUsecase(locator()));
  locator.registerLazySingleton(() => GetMadicineUsecase(locator()));
  locator.registerLazySingleton(
      () => ShowFullScreenNotificationUsecase(locator()));

  // show notification usecase
  locator.registerLazySingleton(() => ShowNotificationUsecase(locator()));
  locator.registerLazySingleton(
      () => ShowFullScreenNotificationUsecase(locator()));

  // trigerr notification usecase
  locator.registerLazySingleton(() =>
      TriggerNotificationUsecase(triggerNotificationRepository: locator()));
  locator.registerLazySingleton(() => TriggerNotificationTenMinuteBeforeUsecase(
      triggerNotificationRepository: locator()));

  // work manager run
  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == "triggerNotificationTask") {
        final triggerNotificationUsecase =
            locator<TriggerNotificationUsecase>();
        log("called");
        await triggerNotificationUsecase.execute();
      } else if (task == "triggerNotificationTenMinuteBeforeTask") {
        final triggerNotificationTenMinuteBeforeUsecase =
            locator<TriggerNotificationTenMinuteBeforeUsecase>();
        log("called");
        await triggerNotificationTenMinuteBeforeUsecase.execute();
      }
      return Future.value(true);
    });
  }

  void setupWorkManager() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager().registerPeriodicTask(
      "triggerNotificationTask",
      "triggerNotificationTask",
      frequency: const Duration(minutes: 10),
    );

    Workmanager().registerPeriodicTask(
      "triggerNotificationTenMinuteBeforeTask",
      "triggerNotificationTenMinuteBeforeTask",
      frequency: const Duration(minutes: 20),
    );
  }

  setupWorkManager();
}
