import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class GetMadicineUsecase {
  final MedicineRepository repository;

  GetMadicineUsecase(this.repository);

  Future<Either<Failure, MedicineEntity>> execute(String medicineId) async {
    return await repository.getMedicine(medicineId);
  }
}
