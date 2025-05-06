import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';

abstract class MedicineLocalDataSource {
  Future<bool> updateMedicine(MedicineModel medicine);
  Future<bool> addMedicine(MedicineModel medicine);
  Future<MedicineModel> getMedicine(String id);
  Future<List<MedicineModel>> getMedicines();
  Future<bool> deleteMedicine(String id);
}

class MedicineLocalDataSourceImpl extends MedicineLocalDataSource {
  final Box<MedicineModel> medicineStorage;
  MedicineLocalDataSourceImpl({required this.medicineStorage});

  @override
  Future<bool> addMedicine(MedicineModel medicine) async {
    try {
      await medicineStorage.put(medicine.medicineId, medicine);
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }

    return true;
  }

  @override
  Future<MedicineModel> getMedicine(String id) async {
    try {
      final medicine = medicineStorage.get(id);
      if (medicine == null) {
        throw CacheFailure(message: 'Medicine not found');
      }
      return medicine;
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<List<MedicineModel>> getMedicines() async {
    try {
      return medicineStorage.values.toList();
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<bool> updateMedicine(MedicineModel medicine) async {
    try {
      medicineStorage.put(medicine.medicineId, medicine);
      return true;
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }

  @override
  Future<bool> deleteMedicine(String id) async {
    try {
      medicineStorage.delete(id);
      return true;
    } catch (e) {
      throw CacheFailure(message: e.toString());
    }
  }
}
