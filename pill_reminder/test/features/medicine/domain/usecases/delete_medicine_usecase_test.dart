import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:pill_reminder/cores/error/failure.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

void main() {
  late DeleteMedicineUsecase useCase;
  late MockMedicineRepository mockMedicineRepository;

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    useCase = DeleteMedicineUsecase(mockMedicineRepository);
  });

  final testData = MedicineTestData.medicineEntity;
  final medicineId = testData.medicineId;
  const errorTest = 'test Error';

  test('should delete medicine from the repository', () async {
    when(
      mockMedicineRepository.deleteMedicine(medicineId),
    ).thenAnswer((_) async => const Right(true));

    final result = await useCase.execute(medicineId);

    expect(result, const Right(true));
    verify(mockMedicineRepository.deleteMedicine(medicineId));
    verifyNoMoreInteractions(mockMedicineRepository);
  });

  test('should return failure when deletion fails', () async {
    when(
      mockMedicineRepository.deleteMedicine(medicineId),
    ).thenAnswer((_) async => const Left(CacheFailure(message: errorTest)));

    final result = await useCase.execute(medicineId);

    expect(result, const Left(CacheFailure(message: errorTest)));
    verify(mockMedicineRepository.deleteMedicine(medicineId));
    verifyNoMoreInteractions(mockMedicineRepository);
  });
}
