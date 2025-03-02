import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_madicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';

import '../../../mock/mock_generator.mocks.dart';
import '../../../test_data/medicine_test_data.dart';

void main() {
  late MedicineBloc medicineBloc;
  late MockMedicineRepository mockMedicineRepository;
  late GetAllMedicineUsecase getAllMedicineUsecase;
  late GetMadicineUsecase getMedicineUsecase;
  late UpdateMedicineUsecase updateMedicineUseCase;
  late DeleteMedicineUsecase deleteMedicineUsecase;
  late AddMedicineUsecase addMedicineUsecase;
  MedicineEntity testData = MedicineEntity(
    medicineId: "",
    name: MedicineTestData.medicineEntity.name,
    interval: MedicineTestData.medicineEntity.interval,
    time: MedicineTestData.medicineEntity.time,
    startDate: MedicineTestData.medicineEntity.startDate,
    medicineAmount: MedicineTestData.medicineEntity.medicineAmount,
    medicineTaken: MedicineTestData.medicineEntity.medicineTaken,
  );

  setUp(() {
    mockMedicineRepository = MockMedicineRepository();
    mockMedicineRepository = MockMedicineRepository();
    getAllMedicineUsecase = GetAllMedicineUsecase(mockMedicineRepository);
    getMedicineUsecase = GetMadicineUsecase(mockMedicineRepository);
    updateMedicineUseCase = UpdateMedicineUsecase(mockMedicineRepository);
    deleteMedicineUsecase = DeleteMedicineUsecase(mockMedicineRepository);
    addMedicineUsecase = AddMedicineUsecase(mockMedicineRepository);

    medicineBloc = MedicineBloc(
      getAllMedicineUsecase: getAllMedicineUsecase,
      getMadicineUsecase: getMedicineUsecase,
      updateMedicineUsecase: updateMedicineUseCase,
      deleteMedicineUsecase: deleteMedicineUsecase,
      addMedicineUseCase: addMedicineUsecase,
    );
  });

  tearDown(() {
    medicineBloc.close();
  });

  group('MedicineBloc Tests', () {
    test("Should posses intial state in the first ", () {
      expect(medicineBloc.state, MedicineInitialState());
    });

    blocTest<MedicineBloc, MedicineState>(
      "The bloc should show loading and list of medicine",
      build: () => medicineBloc,
      setUp: () {
        when(mockMedicineRepository.getMedicines())
            .thenAnswer((_) async => Right([testData]));
      },
      act: (testBloc) {
        testBloc.add(GetMedicineListEvent());
      },
      expect: () => [
        MedicineLoadingState(),
        MedicineLoadedState({
          testData.medicineId: testData,
        }),
      ],
    );

    blocTest<MedicineBloc, MedicineState>(
      "The bloc should show loading and medicine details",
      build: () => medicineBloc,
      setUp: () {
        when(mockMedicineRepository.getMedicine(any))
            .thenAnswer((_) async => Right(testData));
      },
      act: (testBloc) {
        testBloc.add(GetMedicineEvent(medicineId: testData.medicineId));
      },
      expect: () => [
        MedicineLoadingState(),
        MedicineLoadedState({
          testData.medicineId: testData,
        }),
      ],
    );

    blocTest<MedicineBloc, MedicineState>(
      "The bloc should show loading and success state when adding medicine",
      build: () => medicineBloc,
      setUp: () {
        when(mockMedicineRepository.addMedicine(any))
            .thenAnswer((_) async => const Right(true));
      },
      act: (testBloc) {
        testBloc.add(AddMedicineEvent(
            name: testData.name,
            interval: testData.interval,
            time: testData.time,
            startDate: testData.startDate,
            medicineAmount: testData.medicineAmount,
            medicineTaken: testData.medicineTaken));
      },
      expect: () {
        return [
          MedicineLoadingState(),
          MedicineLoadedState({
            testData.medicineId: testData,
          }),
        ];
      },
    );

    blocTest<MedicineBloc, MedicineState>(
      "The bloc should show loading and success state when updating medicine",
      build: () => medicineBloc,
      setUp: () {
        when(mockMedicineRepository.updateMedicine(any))
            .thenAnswer((_) async => const Right(true));
      },
      act: (testBloc) {
        testBloc.add(UpdataeMedicineEvent(
            medicineId: testData.medicineId,
            name: testData.name,
            interval: testData.interval,
            time: testData.time,
            startDate: testData.startDate,
            medicineAmount: testData.medicineAmount,
            medicineTaken: testData.medicineTaken));
      },
      expect: () => [
        MedicineLoadingState(),
        MedicineLoadedState({
          testData.medicineId: testData,
        }),
      ],
    );

    blocTest<MedicineBloc, MedicineState>(
      "The bloc should show loading and success state when deleting medicine",
      build: () => medicineBloc,
      setUp: () {
        when(mockMedicineRepository.deleteMedicine(any))
            .thenAnswer((_) async => const Right(true));
      },
      act: (testBloc) {
        testBloc.add(DeleteMedicineEvent(medicineId: testData.medicineId));
      },
      expect: () => [
        MedicineLoadingState(),
        const MedicineLoadedState({}),
      ],
    );
    // Add more tests here
  });
}
