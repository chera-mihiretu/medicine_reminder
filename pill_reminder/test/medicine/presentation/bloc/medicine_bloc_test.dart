import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pill_reminder/cores/error/failure.dart';
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

  final testData = MedicineTestData.medicineEntity;
  final errorMessage = "Test error message";

  setUp(() {
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
    test("Should have initial state", () {
      expect(medicineBloc.state, MedicineInitialState());
    });

    group('GetMedicineListEvent Tests', () {
      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and loaded states when getting medicine list successfully",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.getMedicines(),
          ).thenAnswer((_) async => Right([testData]));
        },
        act: (bloc) => bloc.add(GetMedicineListEvent()),
        expect:
            () => [
              MedicineLoadingState(),
              MedicineLoadedState([testData]),
            ],
      );

      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and error states when getting medicine list fails",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.getMedicines(),
          ).thenAnswer((_) async => Left(CacheFailure(message: errorMessage)));
        },
        act: (bloc) => bloc.add(GetMedicineListEvent()),
        expect:
            () => [MedicineLoadingState(), MedicineErrorState(errorMessage)],
      );
    });

    group('GetMedicineEvent Tests', () {
      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and loaded states when getting medicine successfully",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.getMedicine(any),
          ).thenAnswer((_) async => Right(testData));
        },
        act:
            (bloc) =>
                bloc.add(GetMedicineEvent(medicineId: testData.medicineId)),
        expect:
            () => [
              MedicineLoadingState(),
              MedicineLoadedState([testData]),
            ],
      );

      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and error states when getting medicine fails",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.getMedicine(any),
          ).thenAnswer((_) async => Left(CacheFailure(message: errorMessage)));
        },
        act:
            (bloc) =>
                bloc.add(GetMedicineEvent(medicineId: testData.medicineId)),
        expect:
            () => [MedicineLoadingState(), MedicineErrorState(errorMessage)],
      );
    });

    group('AddMedicineEvent Tests', () {
      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and added states when adding medicine successfully",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.addMedicine(any),
          ).thenAnswer((_) async => const Right(true));
        },
        act:
            (bloc) => bloc.add(
              AddMedicineEvent(
                name: testData.name,
                interval: testData.interval,
                time: testData.time,
                startDate: testData.startDate,
                medicineAmount: testData.medicineAmount,
                medicineTaken: testData.medicineTaken,
                lastTriggered: testData.lastTriggered,
              ),
            ),
        expect: () => [MedicineLoadingState(), MedicineAddedState()],
      );

      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and error states when adding medicine fails",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.addMedicine(any),
          ).thenAnswer((_) async => Left(CacheFailure(message: errorMessage)));
        },
        act:
            (bloc) => bloc.add(
              AddMedicineEvent(
                name: testData.name,
                interval: testData.interval,
                time: testData.time,
                startDate: testData.startDate,
                medicineAmount: testData.medicineAmount,
                medicineTaken: testData.medicineTaken,
                lastTriggered: testData.lastTriggered,
              ),
            ),
        expect:
            () => [MedicineLoadingState(), MedicineErrorState(errorMessage)],
      );
    });

    group('UpdateMedicineEvent Tests', () {
      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and loaded states when updating medicine successfully",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.updateMedicine(any),
          ).thenAnswer((_) async => const Right(true));
          when(
            mockMedicineRepository.getMedicines(),
          ).thenAnswer((_) async => Right([testData]));
        },
        act:
            (bloc) => bloc.add(
              UpdataeMedicineEvent(
                medicineId: testData.medicineId,
                name: testData.name,
                interval: testData.interval,
                time: testData.time,
                startDate: testData.startDate,
                medicineAmount: testData.medicineAmount,
                medicineTaken: testData.medicineTaken,
                lastTriggered: testData.lastTriggered,
              ),
            ),
        expect:
            () => [
              MedicineLoadingState(),
              MedicineLoadedState([testData]),
            ],
      );

      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and error states when updating medicine fails",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.updateMedicine(any),
          ).thenAnswer((_) async => Left(CacheFailure(message: errorMessage)));
        },
        act:
            (bloc) => bloc.add(
              UpdataeMedicineEvent(
                medicineId: testData.medicineId,
                name: testData.name,
                interval: testData.interval,
                time: testData.time,
                startDate: testData.startDate,
                medicineAmount: testData.medicineAmount,
                medicineTaken: testData.medicineTaken,
                lastTriggered: testData.lastTriggered,
              ),
            ),
        expect:
            () => [MedicineLoadingState(), MedicineErrorState(errorMessage)],
      );
    });

    group('DeleteMedicineEvent Tests', () {
      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and loaded states when deleting medicine successfully",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.deleteMedicine(any),
          ).thenAnswer((_) async => const Right(true));
          when(
            mockMedicineRepository.getMedicines(),
          ).thenAnswer((_) async => Right([]));
        },
        act:
            (bloc) =>
                bloc.add(DeleteMedicineEvent(medicineId: testData.medicineId)),
        expect: () => [MedicineLoadingState(), MedicineLoadedState([])],
      );

      blocTest<MedicineBloc, MedicineState>(
        "Should emit loading and error states when deleting medicine fails",
        build: () => medicineBloc,
        setUp: () {
          when(
            mockMedicineRepository.deleteMedicine(any),
          ).thenAnswer((_) async => Left(CacheFailure(message: errorMessage)));
        },
        act:
            (bloc) =>
                bloc.add(DeleteMedicineEvent(medicineId: testData.medicineId)),
        expect:
            () => [MedicineLoadingState(), MedicineErrorState(errorMessage)],
      );
    });
  });
}
