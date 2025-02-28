import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/domain/usecases/medicine_usecase.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final MedicineUsecase medicineUsecase;

  MedicineBloc({required this.medicineUsecase})
      : super(MedicineInitialState()) {
    on<GetMedicineListEvent>((event, emit) async {
      emit(MedicineLoadingState());

      final result = await medicineUsecase.getMedicineList();

      result.fold(
        (failure) => emit(MedicineErrorState(failure.message)),
        (medicines) {
          Map<String, MedicineEntity> medicineModels = {};
          for (var m in medicines) {
            medicineModels[m.medicineId] = m;
          }
          emit(MedicineLoadedState(medicineModels));
        },
      );
    });
    on<AddMedicineEvent>((event, emit) async {
      final loadedState = state as MedicineLoadedState;
      emit(MedicineLoadingState());

      final medicine = MedicineEntity(
        medicineId: "",
        name: event.name,
        interval: event.interval,
        time: event.time,
        startDate: event.startDate,
      );

      final result = await medicineUsecase.addMedicine(medicine);

      result.fold((failure) => emit(MedicineErrorState(failure.message)),
          (status) {
        loadedState.medicines[medicine.medicineId] = medicine;
        emit(MedicineLoadedState(loadedState.medicines));
      });
    });
    on<UpdataeMedicineEvent>((event, emit) async {
      final loadedState = state as MedicineLoadedState;

      emit(MedicineLoadingState());

      final medicine = MedicineEntity(
        medicineId: event.medicineId,
        name: event.name,
        interval: event.interval,
        time: event.time,
        startDate: event.startDate,
      );

      final result = await medicineUsecase.updateMedicine(medicine);

      result.fold(
        (failure) => emit(MedicineErrorState(failure.message)),
        (status) {
          loadedState.medicines[event.medicineId] = medicine;
          emit(MedicineLoadedState(loadedState.medicines));
        },
      );
    });
    on<DeleteMedicineEvent>((event, emit) async {
      final loadedState = state as MedicineLoadedState;
      emit(MedicineLoadingState());

      final result = await medicineUsecase.deleteMedicine(event.medicineId);

      result.fold(
        (failure) => emit(MedicineErrorState(failure.message)),
        (status) {
          loadedState.medicines.remove(event.medicineId);
          emit(MedicineLoadedState(loadedState.medicines));
        },
      );
    });
  }
}
