import 'dart:developer' as dev;

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/cores/constants/app_data.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/auth/data/data_source/auth_data_source.dart';
import 'package:pill_reminder/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pill_reminder/features/auth/domain/repositories/auth_repository.dart';
import 'package:pill_reminder/features/auth/domain/usecases/auth_state_usecase.dart';
import 'package:pill_reminder/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:pill_reminder/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc.dart';
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

// Add this at the top level
NotificationResponse? pendingNotification;

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

  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());
  final medicineBox = await Hive.openBox<MedicineModel>(AppData.medicineBox);
  locator.registerLazySingleton<Box<MedicineModel>>(() => medicineBox);
  //! local data source
  locator.registerLazySingleton<MedicineLocalDataSource>(
    () => MedicineLocalDataSourceImpl(
      medicineStorage: locator<Box<MedicineModel>>(),
    ),
  );

  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(firebaseAuth: locator()),
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
              DarwinNotificationAction.plain(
                'take_medicine',
                'Taken',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.foreground,
                },
              ),
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
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      notificationActionHandler(response);
    },
    onDidReceiveBackgroundNotificationResponse: notificationActionHandler,
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
  //! Firebase instance
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  //! Auth repo registrationo
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: locator()),
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

  //! auth usecases
  locator.registerLazySingleton(() => SignInUsecase(locator()));
  locator.registerLazySingleton(() => AuthStateUsecase(locator()));
  locator.registerLazySingleton(() => SignOutUsecase(locator()));

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

  locator.registerLazySingleton(
    () => AuthBloc(
      signInUsecase: locator(),
      authStateUsecase: locator(),
      signOutUsecase: locator(),
    ),
  );

  // Add this after all initialization is complete
  WidgetsBinding.instance.addPostFrameCallback((_) {
    handlePendingNotification();
  });
}

@pragma('vm:entry-point')
void notificationActionHandler(NotificationResponse response) {
  dev.log('Notification action received: $response');

  try {
    final GlobalKey<NavigatorState> navigatorKey =
        locator<GlobalKey<NavigatorState>>();

    if (navigatorKey.currentState == null) {
      // Store the notification for later if app is not running
      pendingNotification = response;
      dev.log('App is not running, storing notification for later');
      return;
    }

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
            interval: medicine.interval,
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

          // Check if medicine is completed
          if (updatedMedicine.medicineTaken >= updatedMedicine.medicineAmount) {
            // Delete the medicine if all doses are taken
            medicineBox.delete(medicineId);
            dev.log('Medicine completed and deleted: ${medicine.name}');
          } else {
            // Save updated medicine if not completed
            medicineBox.put(medicineId, updatedMedicine);
          }

          locator<ScheduleNotificationUsecase>().execute();

          dev.log('Flutter action button pressed: $medicine');

          navigatorKey.currentState?.pushNamed(
            MedicineTaken.routeName,
            arguments: updatedMedicine,
          );
        }
      }
    }
  } catch (e) {
    dev.log('Error handling notification: $e');
  }
}

// Add this function to handle pending notifications
void handlePendingNotification() {
  dev.log('Handling pending notification');
  if (pendingNotification != null) {
    dev.log('Handling pending notification');
    notificationActionHandler(pendingNotification!);
    pendingNotification = null;
  }
}
