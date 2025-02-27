import 'package:pill_reminder/cores/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart'; // Keep this import as it is used below

abstract class MedicineRepository {
  Future<Either<Failure, List<MedicineEntity>>> getMedicines();
  Future<Either<Failure, MedicineEntity>> getMedicine(String id);
  Future<Either<Failure, bool>> addMedicine(MedicineEntity medicine);
  Future<Either<Failure, bool>> updateMedicine(MedicineEntity medicine);
  Future<Either<Failure, bool>> deleteMedicine(String id);
}
