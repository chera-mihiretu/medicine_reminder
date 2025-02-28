import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/update_medicine_usecase.dart';

import '../../../mock/mock_generator.mocks.dart';
import '../../../test_data/medicine_test_data.dart';

void main() {
  late UpdateMedicineUsecase useCase;
  late MockMedicineRepository mockMedicineRepository;

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    useCase = UpdateMedicineUsecase(mockMedicineRepository);
  });

  final testData = MedicineTestData.medicineEntity;
  const errorTest = "Test Error";

  test('should update medicine in the repository', () async {
    when(mockMedicineRepository.updateMedicine(testData))
        .thenAnswer((_) async => const Right(true));

    final result = await useCase.execute(testData);

    expect(result, const Right(true));
    verify(mockMedicineRepository.updateMedicine(testData));
    verifyNoMoreInteractions(mockMedicineRepository);
  });

  test('should return failure when updating medicine in the repository fails',
      () async {
    when(mockMedicineRepository.updateMedicine(testData))
        .thenAnswer((_) async => const Left(CacheFailure(message: errorTest)));

    final result = await useCase.execute(testData);

    expect(result, const Left(CacheFailure(message: errorTest)));
    verify(mockMedicineRepository.updateMedicine(testData));
    verifyNoMoreInteractions(mockMedicineRepository);
  });
}
