import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/cores/constants/app_data.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/data/models/time_of_day_adapter.dart';
import 'package:pill_reminder/features/medicine/data/repositories/medicine_repository_impl.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_madicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_taken.dart';
import 'package:pill_reminder/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:pill_reminder/features/notification/data/repositories/trigger_notification_repository_impl.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/usecases/schedule_notification_usecase.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';

final locator = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> init() async {
  //! THeme provider
  locator.registerLazySingleton<ThemeProvider>(
    () => ThemeProvider.withDefaults(),
  );
  //! Hive Initialization and Registration
  await Hive.initFlutter();
  await AndroidAlarmManager.initialize();
  Hive.registerAdapter(MedicineModelAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  final medicineBox = await Hive.openBox<MedicineModel>(AppData.medicineBox);
  locator.registerLazySingleton<Box<MedicineModel>>(() => medicineBox);
  //! local data source
  locator.registerLazySingleton<MedicineLocalDataSource>(
    () => MedicineLocalDataSourceImpl(
      medicineStorage: locator<Box<MedicineModel>>(),
    ),
  );
  //! Flutter Local Notifications Plugin Initialization
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notification channel
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        notificationCategories: [
          DarwinNotificationCategory(
            'medicine_notification',
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.plain('take_medicine', 'Taken'),
            ],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          ),
        ],
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // Handle when notification is tapped or action is pressed
      handleNotificationAction;
    },
  );

  locator.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => flutterLocalNotificationsPlugin,
  );

  //! Repository Registration
  locator.registerLazySingleton<MedicineRepository>(
    () => MedicineRepositoryImpl(localDataSource: locator()),
  );
  locator.registerSingleton<NotificationRepository>(
    NotificationRepositoryImpl(flutterLocalNotificationsPlugin: locator()),
  );
  locator.registerLazySingleton<TriggerNotificationRepository>(
    () => TriggerNotificationRepositoryImpl(
      getAllMedicineUsecase: locator(),
      notificationRepository: locator(),
      medicineLocalDataSource: locator(),
    ),
  );

  //! Usecase Registration
  locator.registerLazySingleton(() => AddMedicineUsecase(locator()));
  locator.registerLazySingleton(() => UpdateMedicineUsecase(locator()));
  locator.registerLazySingleton(() => DeleteMedicineUsecase(locator()));
  locator.registerLazySingleton(() => GetAllMedicineUsecase(locator()));
  locator.registerLazySingleton(() => GetMadicineUsecase(locator()));
  locator.registerLazySingleton(
    () => ScheduleNotificationUsecase(triggerNotificationRepository: locator()),
  );

  //! Backround task

  //! Bloc registration
  locator.registerLazySingleton(
    () => MedicineBloc(
      getAllMedicineUsecase: locator(),
      getMadicineUsecase: locator(),
      addMedicineUseCase: locator(),
      deleteMedicineUsecase: locator(),
      updateMedicineUsecase: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => NotificationBloc(scheduleNotificationUsecase: locator()),
  );
}

@pragma('vm:entry-point')
void handleNotificationAction(NotificationResponse response) async {
  if (response.payload != null) {
    // Parse the payload which contains medicineId:hour:minute
    final parts = response.payload!.split(':');
    if (parts.length == 3) {
      final medicineId = parts[0];

      // Get the medicine from local storage
      final medicineBox = locator<Box<MedicineModel>>();
      final medicine = medicineBox.get(medicineId);

      if (medicine != null) {
        // Update medicine taken count
        final updatedMedicine = MedicineModel(
          medicineId: medicine.medicineId,
          name: medicine.name,
          startDate: medicine.startDate,
          medicineAmount: medicine.medicineAmount,
          medicineTaken: medicine.medicineTaken + 1,
          lastTriggered: TimeOfDay(
            hour: int.parse(parts[1]),
            minute: int.parse(parts[2]),
          ),
          scheduled: medicine.scheduled,
          time: medicine.time,
        );

        // Save updated medicine
        await medicineBox.put(medicineId, updatedMedicine);
        log('Flutter action button pressed: $medicine');
        // Navigate to medicine details page
        navigatorKey.currentState?.pushNamed(
          MedicineTaken.routeName,
          arguments: updatedMedicine,
        );
      }
    }
  }
}
