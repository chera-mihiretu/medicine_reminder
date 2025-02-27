import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

class MedicineTestData {
  static DateTime now = DateTime.now();
  static Map<String, dynamic> medicineJson = {
    'medicineId': '0',
    'name': 'Cloxa',
    'interval': -1,
    'time': [],
    'startDate': now.toIso8601String(),
  };
  static MedicineModel medicineModel = MedicineModel(
      medicineId: '0',
      name: 'Cloxa',
      interval: -1,
      time: const [],
      startDate: now);

  static MedicineEntity medicineEntity = MedicineEntity(
      medicineId: '0',
      name: 'Cloxa',
      interval: -1,
      time: const [],
      startDate: now);
}
