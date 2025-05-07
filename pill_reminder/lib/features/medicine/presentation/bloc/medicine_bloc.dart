import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/get_madicine_usecase.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final GetAllMedicineUsecase getAllMedicineUsecase;
  final GetMadicineUsecase getMadicineUsecase;

  final AddMedicineUsecase addMedicineUseCase;
  final DeleteMedicineUsecase deleteMedicineUsecase;
  final UpdateMedicineUsecase updateMedicineUsecase;
  MedicineBloc({
    required this.getAllMedicineUsecase,
    required this.getMadicineUsecase,
    required this.addMedicineUseCase,
    required this.deleteMedicineUsecase,
    required this.updateMedicineUsecase,
  }) : super(MedicineInitialState()) {
    on<GetMedicineListEvent>((event, emit) async {
      emit(MedicineLoadingState());

      final result = await getAllMedicineUsecase.execute();
      result.fold((failure) => emit(MedicineErrorState(failure.message)), (
        medicines,
      ) {
        emit(MedicineLoadedState(medicines));
      });
    });

    on<GetMedicineEvent>((event, emit) async {
      emit(MedicineLoadingState());

      final result = await getMadicineUsecase.execute(event.medicineId);

      result.fold((failure) => emit(MedicineErrorState(failure.message)), (
        medicine,
      ) {
        emit(MedicineLoadedState([medicine]));
      });
    });

    on<AddMedicineEvent>((event, emit) async {
      emit(MedicineLoadingState());

      final medicine = MedicineEntity(
        medicineId:
            (DateTime.now().millisecondsSinceEpoch % (pow(10, 9) + 7))
                .toString(),
        name: event.name,
        interval: event.interval,
        time: event.time,
        startDate: event.startDate,
        medicineAmount: event.medicineAmount,
        medicineTaken: event.medicineTaken,
        lastTriggered: event.lastTriggered,
        scheduled: false,
      );
      final result = await addMedicineUseCase.execute(medicine);

      result.fold((failure) => emit(MedicineErrorState(failure.message)), (
        status,
      ) {
        emit(MedicineAddedState());
      });
    });
    on<UpdataeMedicineEvent>((event, emit) async {
      final MedicineLoadedState loadedState;
      final medicine = MedicineEntity(
        medicineId: event.medicineId,
        name: event.name,
        interval: event.interval,
        time: event.time,
        startDate: event.startDate,
        medicineAmount: event.medicineAmount,
        medicineTaken: event.medicineTaken,
        lastTriggered: event.lastTriggered,
        scheduled: false,
      );
      if (state is MedicineLoadedState) {
        loadedState = state as MedicineLoadedState;
      } else {
        loadedState = MedicineLoadedState([]);
      }

      emit(MedicineLoadingState());

      final result = await updateMedicineUsecase.execute(medicine);

      result.fold((failure) => emit(MedicineErrorState(failure.message)), (
        status,
      ) {
        // Find and update the existing medicine
        final updatedMedicines = List<MedicineEntity>.from(
          loadedState.medicines,
        );
        final index = updatedMedicines.indexWhere(
          (m) => m.medicineId == medicine.medicineId,
        );
        if (index != -1) {
          updatedMedicines[index] = medicine;
          emit(MedicineLoadedState(updatedMedicines));
        } else {
          emit(MedicineLoadedState([medicine]));
        }
      });
    });

    on<DeleteMedicineEvent>((event, emit) async {
      final MedicineLoadedState loadedState;
      if (state is MedicineLoadedState) {
        loadedState = state as MedicineLoadedState;
      } else {
        loadedState = const MedicineLoadedState([]);
      }

      emit(MedicineLoadingState());

      final result = await deleteMedicineUsecase.execute(event.medicineId);

      result.fold((failure) => emit(MedicineErrorState(failure.message)), (
        status,
      ) {
        for (int i = 0; i < loadedState.medicines.length; ++i) {
          if (loadedState.medicines[i].medicineId == event.medicineId) {
            loadedState.medicines.removeAt(i);
            break;
          }
        }
        emit(MedicineLoadedState(loadedState.medicines));
      });
    });
  }
}
