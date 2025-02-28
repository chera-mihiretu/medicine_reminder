import 'package:equatable/equatable.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

sealed class MedicineState extends Equatable {
  const MedicineState();

  @override
  List<Object> get props => [];
}

class MedicineInitialState extends MedicineState {}

class MedicineLoadingState extends MedicineState {}

class MedicineLoadedState extends MedicineState {
  final Map<String, MedicineEntity> medicines;

  const MedicineLoadedState(this.medicines);

  @override
  List<Object> get props => [medicines];
}

class MedicineErrorState extends MedicineState {
  final String message;

  const MedicineErrorState(this.message);

  @override
  List<Object> get props => [message];
}
