import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:pill_reminder/features/medicine/data/repositories/medicine_repository_impl.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

void main() {
  late MockMedicineLocalDataSource mockMedicineLocalDataSource;
  late MedicineRepositoryImpl medicineRepositoryImpl;
  MedicineModel testModelData = MedicineTestData.medicineModel;
  MedicineEntity testEntityData = MedicineTestData.medicineEntity;
  String testError = "error";

  setUp(() {
    mockMedicineLocalDataSource = MockMedicineLocalDataSource();
    medicineRepositoryImpl = MedicineRepositoryImpl(
      localDataSource: mockMedicineLocalDataSource,
    );
  });

  group('addMedicine', () {
    test('addMedicine should add medicine to local data source', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.addMedicine(any),
      ).thenAnswer((_) async => true);

      // act
      final result = await medicineRepositoryImpl.addMedicine(testEntityData);

      // assert
      expect(result, const Right(true));
      verify(mockMedicineLocalDataSource.addMedicine(any)).called(1);
    });

    test(
      'addMedicine should return CacheFailure when there is an exception',
      () async {
        // arrange
        when(
          mockMedicineLocalDataSource.addMedicine(any),
        ).thenThrow(CacheFailure(message: 'error'));

        // act
        final result = await medicineRepositoryImpl.addMedicine(testEntityData);

        // assert
        expect(result, Left(CacheFailure(message: 'error')));
        verify(mockMedicineLocalDataSource.addMedicine(any)).called(1);
      },
    );
  });

  group('deleteMedicine', () {
    test('should delete medicine from local data source', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.deleteMedicine(testModelData.medicineId),
      ).thenAnswer((_) async => true);

      // act
      final result = await medicineRepositoryImpl.deleteMedicine(
        testModelData.medicineId,
      );

      // assert
      expect(result, const Right(true));
      verify(
        mockMedicineLocalDataSource.deleteMedicine(testModelData.medicineId),
      );
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });

    test('should return CacheFailure when there is an exception', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.deleteMedicine(testModelData.medicineId),
      ).thenThrow(Exception('Cache error'));

      // act
      final result = await medicineRepositoryImpl.deleteMedicine(
        testModelData.medicineId,
      );

      // assert
      expect(result, isA<Left<Failure, bool>>());

      verify(
        mockMedicineLocalDataSource.deleteMedicine(testModelData.medicineId),
      );
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });
  });

  group('getMedicine', () {
    test('getMedicine should return medicine from local data source', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.getMedicine(any),
      ).thenAnswer((_) async => testModelData);

      // act
      final result = await medicineRepositoryImpl.getMedicine(
        testModelData.medicineId,
      );

      // assert
      expect(result, Right(testModelData.toEntity()));
      verify(mockMedicineLocalDataSource.getMedicine(any)).called(1);
    });

    test('should return CacheFailure when there is an exception', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.getMedicine(testModelData.medicineId),
      ).thenThrow(Exception(testError));

      // act
      final result = await medicineRepositoryImpl.getMedicine(
        testModelData.medicineId,
      );

      // assert
      expect(result, isA<Left<Failure, MedicineEntity>>());

      verify(mockMedicineLocalDataSource.getMedicine(testModelData.medicineId));
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });
  });

  group('getMedicines', () {
    final List<MedicineModel> medicineModels = [testModelData];
    final List<MedicineEntity> medicineEntities =
        medicineModels.map((e) => e.toEntity()).toList();

    test('should return list of medicines from local data source', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.getMedicines(),
      ).thenAnswer((_) async => medicineModels);

      // act
      final result = await medicineRepositoryImpl.getMedicines();

      final List<MedicineEntity> resultList = result.fold((l) => [], (r) => r);
      expect(resultList, medicineEntities);
      verify(mockMedicineLocalDataSource.getMedicines());
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });

    test('should return CacheFailure when there is an exception', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.getMedicines(),
      ).thenThrow(Exception('Cache error'));

      // act
      final result = await medicineRepositoryImpl.getMedicines();

      // assert
      expect(result, isA<Left<Failure, List<MedicineEntity>>>());
      verify(mockMedicineLocalDataSource.getMedicines());
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });
  });

  group('updateMedicine', () {
    test('should update medicine in local data source', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.updateMedicine(testModelData),
      ).thenAnswer((_) async => true);

      // act
      final result = await medicineRepositoryImpl.updateMedicine(testModelData);

      // assert
      expect(result, const Right(true));
      verify(mockMedicineLocalDataSource.updateMedicine(testModelData));
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });

    test('should return CacheFailure when there is an exception', () async {
      // arrange
      when(
        mockMedicineLocalDataSource.updateMedicine(testModelData),
      ).thenThrow(Exception('Cache error'));

      // act
      final result = await medicineRepositoryImpl.updateMedicine(testModelData);

      // assert
      expect(result, isA<Left<Failure, bool>>());
      verify(mockMedicineLocalDataSource.updateMedicine(testModelData));
      verifyNoMoreInteractions(mockMedicineLocalDataSource);
    });
  });
}
