import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class MedicineUsecase {
  final MedicineRepository repository;

  MedicineUsecase(this.repository);

  Future<Either<Failure, List<MedicineEntity>>> getMedicineList() async {
    return await repository.getMedicines();
  }

  Future<Either<Failure, bool>> addMedicine(MedicineEntity medicine) async {
    return await repository.addMedicine(medicine);
  }

  Future<Either<Failure, bool>> updateMedicine(MedicineEntity medicine) async {
    return await repository.updateMedicine(medicine);
  }

  Future<Either<Failure, bool>> deleteMedicine(String medicineId) async {
    return await repository.deleteMedicine(medicineId);
  }
}
