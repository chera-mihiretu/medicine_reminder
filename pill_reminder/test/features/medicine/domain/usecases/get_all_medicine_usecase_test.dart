import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';

import '../../../../mock/mock_generator.mocks.dart';
import '../../../../test_data/medicine_test_data.dart';

void main() {
  late GetAllMedicineUsecase useCase;
  late MockMedicineRepository mockMedicineRepository;

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    useCase = GetAllMedicineUsecase(mockMedicineRepository);
  });

  final testData = MedicineTestData.medicineEntity;

  final testDataList = [
    testData,
  ];

  const errorTest = "Test Error";

  test('should get all medicines from the repository', () async {
    when(mockMedicineRepository.getMedicines())
        .thenAnswer((_) async => Right(testDataList));

    final result = await useCase.execute();

    expect(result, Right(testDataList));
    verify(mockMedicineRepository.getMedicines());
    verifyNoMoreInteractions(mockMedicineRepository);
  });

  test('should return failure when repository fails', () async {
    when(mockMedicineRepository.getMedicines())
        .thenAnswer((_) async => const Left(CacheFailure(message: errorTest)));

    final result = await useCase.execute();

    expect(result, const Left(CacheFailure(message: errorTest)));
    verify(mockMedicineRepository.getMedicines());
    verifyNoMoreInteractions(mockMedicineRepository);
  });
}
