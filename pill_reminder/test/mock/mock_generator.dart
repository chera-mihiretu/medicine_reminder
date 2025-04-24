import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/notification/data/callbacks/notification_callback.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_full_screen_notification_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart';

@GenerateMocks([
  MedicineRepository,
  Box,
  MedicineLocalDataSource,
  FlutterLocalNotificationsPlugin,
  ShowNotificationUsecase,
  ShowFullScreenNotificationUsecase,
  GetAllMedicineUsecase,
  NotificationRepository,
  NotificationCallback,
], customMocks: [])
void main() {}
