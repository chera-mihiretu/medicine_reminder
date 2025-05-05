import 'package:flutter_test/flutter_test.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

import '../../../test_data/medicine_test_data.dart';

void main() {
  MedicineModel fromJson = MedicineTestData.medicineModel;
  MedicineEntity medicineEntity = MedicineTestData.medicineEntity;
  MedicineModel testExpect = MedicineModel(
    medicineId: medicineEntity.medicineId,
    name: medicineEntity.name,
    interval: medicineEntity.interval,
    time: medicineEntity.time,
    startDate: medicineEntity.startDate,
    medicineAmount: medicineEntity.medicineAmount,
    medicineTaken: medicineEntity.medicineTaken,
    lastTriggered: medicineEntity.lastTriggered,
    scheduled: medicineEntity.scheduled,
  );
  Map<String, dynamic> testInput = MedicineTestData.medicineJson;

  group("Extending test", () {
    test("Medicine model is not extending Medicine Entity", () {
      expect(testExpect, isA<MedicineEntity>());
    });
  });

  group("Conversion test", () {
    test("Medicine model is not converting to json", () {
      expect(fromJson.toJson(), testInput);
    });

    test("Medicine model is converting to entity", () {
      expect(fromJson.toEntity(), isA<MedicineEntity>());
    });

    test('Should convert from entity to model', () {
      expect(MedicineModel.fromEntity(medicineEntity), testExpect);
    });
  });
}
