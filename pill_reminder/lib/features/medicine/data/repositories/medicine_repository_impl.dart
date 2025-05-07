import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/repositories/medicine_repository.dart';

class MedicineRepositoryImpl extends MedicineRepository {
  final MedicineLocalDataSource localDataSource;

  MedicineRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> addMedicine(MedicineEntity medicine) async {
    try {
      MedicineModel medicineModel = MedicineModel.fromEntity(medicine);
      bool added = await localDataSource.addMedicine(medicineModel);

      return Right(added);
    } catch (e) {
      if (e is Failure) {
        return Left(CacheFailure(message: e.message));
      }
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMedicine(String id) async {
    try {
      await localDataSource.deleteMedicine(id);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MedicineEntity>> getMedicine(String id) async {
    try {
      final MedicineModel result = await localDataSource.getMedicine(id);

      return Right(result.toEntity());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getMedicines() async {
    try {
      final List<MedicineModel> result = await localDataSource.getMedicines();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      if (e is Failure) {
        Left(CacheFailure(message: e.message));
      }
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMedicine(MedicineEntity medicine) async {
    try {
      final result = await localDataSource.updateMedicine(
        MedicineModel.fromEntity(medicine),
      );
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
