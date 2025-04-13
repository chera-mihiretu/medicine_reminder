import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class GetAllMedicineUsecase {
  final MedicineRepository repository;

  GetAllMedicineUsecase(this.repository);

  Future<Either<Failure, List<MedicineEntity>>> execute() async {
    return await repository.getMedicines();
  }
}
