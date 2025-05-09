import 'package:flutter_test/flutter_test.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

import '../../../../test_data/medicine_test_data.dart';

void main() {
  MedicineModel testExpect = MedicineTestData.medicineModel;
  MedicineEntity medicineEntity = MedicineTestData.medicineEntity;
  Map<String, dynamic> testInput = MedicineTestData.medicineJson;

  group('Extending test', () {
    test('Medicine model is not extending Medicine Entity', () {
      expect(testExpect, isA<MedicineModel>());
    });
  });

  group('Conversion test', () {
    test('Medicine model is not converting to json', () {
      expect(testExpect.toJson(), testInput);
    });

    test('Medicine model is converting to entity', () {
      expect(testExpect.toEntity(), isA<MedicineEntity>());
    });

    test('Should convert from entity to model', () {
      final toExpect = MedicineModel(
        medicineId: medicineEntity.medicineId,
        name: medicineEntity.name,
        interval: medicineEntity.interval,
        time: medicineEntity.time,
        startDate: medicineEntity.startDate,
        medicineAmount: medicineEntity.medicineAmount,
        medicineTaken: medicineEntity.medicineTaken,
        lastTriggered: medicineEntity.lastTriggered,
      );

      expect(MedicineModel.fromEntity(medicineEntity), toExpect);
    });
  });
}
