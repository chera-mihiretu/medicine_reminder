import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/data/data_resources/medicine_local_data_source.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

void main() {
  late MockBox<MedicineModel> mockBox;

  late MedicineLocalDataSourceImpl testDataLocalDataSourceImpl;

  MedicineModel testData = MedicineTestData.medicineModel;

  setUp(() {
    mockBox = MockBox();
    testDataLocalDataSourceImpl = MedicineLocalDataSourceImpl(
      medicineStorage: mockBox,
    );
  });

  group("Testing all data retrieval and store", () {
    test('should retrieve and store all test data correctly', () async {
      // arrange
      when(
        mockBox.put(testData.medicineId, testData),
      ).thenAnswer((_) async => true);
      when(mockBox.get(testData.medicineId)).thenReturn(testData);
      when(mockBox.values).thenReturn([testData]);

      // act
      final addResult = await testDataLocalDataSourceImpl.addMedicine(testData);
      final getResult = await testDataLocalDataSourceImpl.getMedicine(
        testData.medicineId,
      );
      final getAllResult = await testDataLocalDataSourceImpl.getMedicines();

      // assert
      expect(addResult, true);
      expect(getResult, testData);
      expect(getAllResult, [testData]);
      verify(mockBox.put(testData.medicineId, testData)).called(1);
      verify(mockBox.get(testData.medicineId)).called(1);
      verify(mockBox.values).called(1);
    });

    test('should throw CacheFailure when any operation fails', () async {
      // arrange
      when(mockBox.put(testData.medicineId, testData)).thenThrow(Exception());
      when(mockBox.get(testData.medicineId)).thenThrow(Exception());
      when(mockBox.values).thenThrow(Exception());

      // act & assert
      expect(
        () => testDataLocalDataSourceImpl.addMedicine(testData),
        throwsA(isA<CacheFailure>()),
      );
      expect(
        () => testDataLocalDataSourceImpl.getMedicine(testData.medicineId),
        throwsA(isA<CacheFailure>()),
      );
      expect(
        () => testDataLocalDataSourceImpl.getMedicines(),
        throwsA(isA<CacheFailure>()),
      );
    });
  });
  group('addMedicine', () {
    test('should add a testData', () async {
      // arrange
      when(
        mockBox.put(testData.medicineId, testData),
      ).thenAnswer((_) async => true);

      // act
      final result = await testDataLocalDataSourceImpl.addMedicine(testData);

      // assert
      expect(result, true);
      verify(mockBox.put(testData.medicineId, testData)).called(1);
    });

    test('should throw a CacheFailure when adding a testData fails', () async {
      // arrange
      when(mockBox.put(testData.medicineId, testData)).thenThrow(Exception());

      // act
      final call = testDataLocalDataSourceImpl.addMedicine(testData);

      // assert
      expect(() async => call, throwsA(isA<CacheFailure>()));
      verify(mockBox.put(testData.medicineId, testData)).called(1);
    });
  });

  group('getMedicine', () {
    test('should get a testData by id', () async {
      // arrange
      when(mockBox.get(testData.medicineId)).thenReturn(testData);

      // act
      final result = await testDataLocalDataSourceImpl.getMedicine(
        testData.medicineId,
      );

      // assert
      expect(result, testData);
      verify(mockBox.get(testData.medicineId)).called(1);
    });

    test(
      'should throw a CacheFailure when getting a testData by id fails',
      () async {
        // arrange
        when(mockBox.get(testData.medicineId)).thenThrow(Exception());

        // act
        final call = testDataLocalDataSourceImpl.getMedicine(
          testData.medicineId,
        );

        // assert
        expect(() async => call, throwsA(isA<CacheFailure>()));
        verify(mockBox.get(testData.medicineId)).called(1);
      },
    );
  });

  group('getMedicines', () {
    test('should get all testDatas', () async {
      // arrange
      final testDatasList = [testData];
      when(mockBox.values).thenReturn(testDatasList);

      // act
      final result = await testDataLocalDataSourceImpl.getMedicines();

      // assert
      expect(result, testDatasList);
      verify(mockBox.values).called(1);
    });

    test(
      'should throw a CacheFailure when getting all testDatas fails',
      () async {
        // arrange
        when(mockBox.values).thenReturn([]);

        // act
        final call = await testDataLocalDataSourceImpl.getMedicines();

        // assert
        expect(call, []);
        verify(mockBox.values).called(1);
      },
    );
  });

  group('updateMedicine', () {
    test('should update a testData', () async {
      // arrange
      when(
        mockBox.put(testData.medicineId, testData),
      ).thenAnswer((_) async => true);

      // act
      final result = await testDataLocalDataSourceImpl.updateMedicine(testData);

      // assert
      expect(result, true);
      verify(mockBox.put(testData.medicineId, testData)).called(1);
    });

    test(
      'should throw a CacheFailure when updating a testData fails',
      () async {
        // arrange
        when(mockBox.put(testData.medicineId, testData)).thenThrow(Exception());

        // act
        final call = testDataLocalDataSourceImpl.updateMedicine(testData);

        // assert
        expect(() async => call, throwsA(isA<CacheFailure>()));
        verify(mockBox.put(testData.medicineId, testData)).called(1);
      },
    );
  });

  group('deleteMedicine', () {
    test('should delete a testData by id', () async {
      // arrange
      when(mockBox.delete(testData.medicineId)).thenAnswer((_) async => true);

      // act
      final result = await testDataLocalDataSourceImpl.deleteMedicine(
        testData.medicineId,
      );

      // assert
      expect(result, true);
      verify(mockBox.delete(testData.medicineId)).called(1);
    });

    test(
      'should throw a CacheFailure when deleting a testData by id fails',
      () async {
        // arrange
        when(mockBox.delete(testData.medicineId)).thenThrow(Exception());

        // act
        final call = testDataLocalDataSourceImpl.deleteMedicine(
          testData.medicineId,
        );

        // assert
        expect(() async => call, throwsA(isA<CacheFailure>()));
        verify(mockBox.delete(testData.medicineId)).called(1);
      },
    );
  });
}
