import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class AddMedicineUsecase {
  final MedicineRepository repository;

  AddMedicineUsecase(this.repository);

  Future<Either<Failure, void>> execute(MedicineEntity medicine) async {
    return await repository.addMedicine(medicine);
  }
}
