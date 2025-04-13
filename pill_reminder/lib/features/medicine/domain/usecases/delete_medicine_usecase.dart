import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class DeleteMedicineUsecase {
  final MedicineRepository repository;

  DeleteMedicineUsecase(this.repository);
  Future<Either<Failure, void>> execute(String medicineId) async {
    return await repository.deleteMedicine(medicineId);
  }
}
