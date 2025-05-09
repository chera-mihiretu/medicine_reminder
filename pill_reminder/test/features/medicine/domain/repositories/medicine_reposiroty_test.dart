import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

void main() {
  MedicineEntity medicineEntity = MedicineTestData.medicineEntity;

  List<MedicineEntity> testList = [medicineEntity];

  late MockMedicineRepository medicineRepository;

  setUp(() {
    medicineRepository = MockMedicineRepository();
  });

  group('All Functions Should Work', () {
    test('should get list of medicines', () async {
      // arrange
      when(
        medicineRepository.getMedicines(),
      ).thenAnswer((_) async => Right(testList));
      // act
      final result = await medicineRepository.getMedicines();
      // assert
      expect(result, equals(Right<Failure, List<MedicineEntity>>(testList)));

      verify(medicineRepository.getMedicines());
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should get a single medicine by id', () async {
      // arrange
      when(
        medicineRepository.getMedicine(any),
      ).thenAnswer((_) async => Right(medicineEntity));
      // act
      final result = await medicineRepository.getMedicine(
        medicineEntity.medicineId,
      );
      // assert
      expect(result, Right(medicineEntity));
      verify(medicineRepository.getMedicine(medicineEntity.medicineId));
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should add a new medicine', () async {
      // arrange
      when(
        medicineRepository.addMedicine(any),
      ).thenAnswer((_) async => const Right(true));
      // act
      final result = await medicineRepository.addMedicine(medicineEntity);
      // assert
      expect(result, const Right(true));
      verify(medicineRepository.addMedicine(medicineEntity));
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should update an existing medicine', () async {
      // arrange
      when(
        medicineRepository.updateMedicine(any),
      ).thenAnswer((_) async => const Right(true));
      // act
      final result = await medicineRepository.updateMedicine(medicineEntity);
      // assert
      expect(result, const Right(true));
      verify(medicineRepository.updateMedicine(medicineEntity));
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should delete a medicine by id', () async {
      // arrange
      when(
        medicineRepository.deleteMedicine(any),
      ).thenAnswer((_) async => const Right(true));
      // act
      final result = await medicineRepository.deleteMedicine(
        medicineEntity.medicineId,
      );
      // assert
      expect(result, const Right(true));
      verify(medicineRepository.deleteMedicine(medicineEntity.medicineId));
      verifyNoMoreInteractions(medicineRepository);
    });
  });

  group('Failure Part Should also have to work', () {
    test('should return failure when getting list of medicines', () async {
      // arrange
      when(
        medicineRepository.getMedicines(),
      ).thenAnswer((_) async => const Left(CacheFailure(message: '')));
      // act
      final result = await medicineRepository.getMedicines();
      // assert
      expect(
        result,
        equals(
          const Left<Failure, List<MedicineEntity>>(CacheFailure(message: '')),
        ),
      );
      verify(medicineRepository.getMedicines());
      verifyNoMoreInteractions(medicineRepository);
    });

    test(
      'should return failure when getting a single medicine by id',
      () async {
        // arrange
        when(
          medicineRepository.getMedicine(any),
        ).thenAnswer((_) async => const Left(CacheFailure(message: '')));
        // act
        final result = await medicineRepository.getMedicine(
          medicineEntity.medicineId,
        );
        // assert
        expect(
          result,
          equals(
            const Left<Failure, MedicineEntity>(CacheFailure(message: '')),
          ),
        );
        verify(medicineRepository.getMedicine(medicineEntity.medicineId));
        verifyNoMoreInteractions(medicineRepository);
      },
    );

    test('should return failure when adding a new medicine', () async {
      // arrange
      when(
        medicineRepository.addMedicine(any),
      ).thenAnswer((_) async => const Left(CacheFailure(message: '')));
      // act
      final result = await medicineRepository.addMedicine(medicineEntity);
      // assert
      expect(
        result,
        equals(const Left<Failure, bool>(CacheFailure(message: ''))),
      );
      verify(medicineRepository.addMedicine(medicineEntity));
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should return failure when updating an existing medicine', () async {
      // arrange
      when(
        medicineRepository.updateMedicine(any),
      ).thenAnswer((_) async => const Left(CacheFailure(message: '')));
      // act
      final result = await medicineRepository.updateMedicine(medicineEntity);
      // assert
      expect(
        result,
        equals(const Left<Failure, bool>(CacheFailure(message: ''))),
      );
      verify(medicineRepository.updateMedicine(medicineEntity));
      verifyNoMoreInteractions(medicineRepository);
    });

    test('should return failure when deleting a medicine by id', () async {
      // arrange
      when(
        medicineRepository.deleteMedicine(any),
      ).thenAnswer((_) async => const Left(CacheFailure(message: '')));
      // act
      final result = await medicineRepository.deleteMedicine(
        medicineEntity.medicineId,
      );
      // assert
      expect(
        result,
        equals(const Left<Failure, bool>(CacheFailure(message: ''))),
      );
      verify(medicineRepository.deleteMedicine(medicineEntity.medicineId));
      verifyNoMoreInteractions(medicineRepository);
    });
  });
}
