import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

@GenerateMocks([
  MedicineRepository,
  Box,
  MedicineLocalDataSource,
  FlutterLocalNotificationsPlugin
], customMocks: [])
void main() {}
