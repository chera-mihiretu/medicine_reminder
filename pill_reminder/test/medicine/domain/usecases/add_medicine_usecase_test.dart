import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/add_medicine_usecase.dart';

import '../../../mock/mock_generator.mocks.dart';
import '../../../test_data/medicine_test_data.dart';

void main() {
  late AddMedicineUsecase useCase;
  late MockMedicineRepository mockMedicineRepository;

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    useCase = AddMedicineUsecase(mockMedicineRepository);
  });

  final testData = MedicineTestData.medicineEntity;
  const errorTest = "Test Error";

  test('should add medicine to the repository', () async {
    when(mockMedicineRepository.addMedicine(testData))
        .thenAnswer((_) async => const Right(true));

    final result = await useCase.execute(testData);

    expect(result, const Right(true));
    verify(mockMedicineRepository.addMedicine(testData));
    verifyNoMoreInteractions(mockMedicineRepository);
  });

  test('should return failure when adding medicine to the repository fails',
      () async {
    when(mockMedicineRepository.addMedicine(testData))
        .thenAnswer((_) async => const Left(CacheFailure(message: errorTest)));

    final result = await useCase.execute(testData);

    expect(result, const Left(CacheFailure(message: errorTest)));
    verify(mockMedicineRepository.addMedicine(testData));
    verifyNoMoreInteractions(mockMedicineRepository);
  });
}
