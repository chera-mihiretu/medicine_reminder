import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_madicine_usecase.dart';

import '../../../mock/mock_generator.mocks.dart';
import '../../../test_data/medicine_test_data.dart';

void main() {
  late GetMadicineUsecase useCase;
  late MockMedicineRepository mockMedicineRepository;

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    useCase = GetMadicineUsecase(mockMedicineRepository);
  });

  final testData = MedicineTestData.medicineEntity;
  final medicineId = testData.medicineId;
  const errorTest = 'Test Error';

  test('should get medicine from the repository', () async {
    when(
      mockMedicineRepository.getMedicine(medicineId),
    ).thenAnswer((_) async => Right(testData));

    final result = await useCase.execute(medicineId);

    expect(result, Right(testData));
    verify(mockMedicineRepository.getMedicine(medicineId));
    verifyNoMoreInteractions(mockMedicineRepository);
  });

  test(
    'should return failure when getting medicine from the repository fails',
    () async {
      when(
        mockMedicineRepository.getMedicine(medicineId),
      ).thenAnswer((_) async => const Left(CacheFailure(message: errorTest)));

      final result = await useCase.execute(medicineId);

      expect(result, const Left(CacheFailure(message: errorTest)));
      verify(mockMedicineRepository.getMedicine(medicineId));
      verifyNoMoreInteractions(mockMedicineRepository);
    },
  );
}
