import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_input.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/loading_popup.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_mode.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_time.dart';
import 'package:provider/provider.dart';

class EditMedicinePage extends StatelessWidget {
  static const String routeName = '/edit-medicine';
  final int medicineIndex;

  // Class level variables
  late TextEditingController medicineNameController;
  late TextEditingController intervalController;
  late TextEditingController lastTakenController;
  late TextEditingController totalAmountController;
  late TextEditingController takenAmountController;
  late List<TimeOfDay> selectedTime;
  late List<TextEditingController> specificTimeControllers;
  late List<TimeOfDay> lastTakenTime;
  late MedicineMode medicineMode;

  EditMedicinePage({super.key, required this.medicineIndex}) {
    // Initialize controllers
    medicineNameController = TextEditingController();
    intervalController = TextEditingController();
    lastTakenController = TextEditingController();
    totalAmountController = TextEditingController();
    takenAmountController = TextEditingController();
    selectedTime = [];
    specificTimeControllers = [];
    lastTakenTime = [TimeOfDay.now()];
    medicineMode = MedicineMode.interval;
  }

  void initializeControllers(MedicineEntity medicine) {
    medicineNameController.text = medicine.name;
    intervalController.text = medicine.interval?.toString() ?? '';
    totalAmountController.text = medicine.medicineAmount.toString();
    takenAmountController.text = medicine.medicineTaken.toString();

    // Clear and initialize specific time controllers
    specificTimeControllers.clear();
    selectedTime.clear();
    selectedTime.addAll(medicine.time ?? [TimeOfDay.now()]);

    if (medicine.time != null && medicine.time!.isNotEmpty) {
      for (var time in medicine.time!) {
        int hour = time.hour;
        String period = time.period.toString().split('.').last.toUpperCase();

        // Convert to 12-hour format
        if (hour > 12) {
          hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }

        specificTimeControllers.add(
          TextEditingController(
            text: '$hour:${time.minute.toString().padLeft(2, '0')} $period',
          ),
        );
      }
    } else {
      specificTimeControllers.add(TextEditingController());
    }

    medicineMode =
        medicine.interval != null
            ? MedicineMode.interval
            : MedicineMode.specificTime;
  }

  String? validateInputs(
    BuildContext context, {
    required TextEditingController medicineNameController,
    required TextEditingController totalAmountController,
    required TextEditingController takenAmountController,
    required TextEditingController intervalController,
    required List<TimeOfDay> selectedTime,
    required List<TextEditingController> specificTimeControllers,
    required MedicineMode medicineMode,
  }) {
    // Validate medicine name
    if (medicineNameController.text.trim().isEmpty) {
      return 'Medicine name is required';
    }

    // Validate medicine amount
    if (totalAmountController.text.trim().isEmpty) {
      return 'Total medicine amount is required';
    }

    final totalAmount = int.tryParse(totalAmountController.text);
    if (totalAmount == null || totalAmount <= 0) {
      return 'Total medicine amount must be greater than 0';
    }

    // Validate taken amount if provided
    if (takenAmountController.text.trim().isNotEmpty) {
      final takenAmount = int.tryParse(takenAmountController.text);
      if (takenAmount == null) {
        return 'Invalid taken amount';
      }
      if (takenAmount > totalAmount) {
        return 'Taken amount cannot be greater than total amount';
      }
    }

    // Validate interval or specific time based on mode
    if (medicineMode == MedicineMode.interval) {
      if (intervalController.text.trim().isEmpty) {
        return 'Interval is required';
      }
      final interval = double.tryParse(intervalController.text);
      if (interval == null || interval < 0.02) {
        return 'Interval must be atleast 0.02';
      }
    } else {
      if (selectedTime.isEmpty) {
        return 'Please add at least one specific time for the medicine';
      } else {
        if (specificTimeControllers[0].text.trim().isEmpty) {
          return 'You are not allowed to add empty time';
        }
      }
      if (selectedTime.length > 5) {
        return 'Maximum 5 specific times can be added';
      }
    }

    return null;
  }

  Future<void> handleUpdateMedicine(
    BuildContext context, {
    required TextEditingController medicineNameController,
    required TextEditingController totalAmountController,
    required TextEditingController takenAmountController,
    required TextEditingController intervalController,
    required List<TimeOfDay> selectedTime,
    required List<TextEditingController> specificTimeControllers,
    required MedicineMode medicineMode,
    required String medicineId,
    required DateTime startDate,
    required TimeOfDay lastTriggered,
  }) async {
    final validationError = validateInputs(
      context,
      medicineNameController: medicineNameController,
      totalAmountController: totalAmountController,
      takenAmountController: takenAmountController,
      intervalController: intervalController,
      selectedTime: selectedTime,
      specificTimeControllers: specificTimeControllers,
      medicineMode: medicineMode,
    );

    if (validationError != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validationError)));
      return;
    }

    double? interval;
    List<TimeOfDay>? specificTime;

    if (medicineMode == MedicineMode.interval) {
      interval = double.parse(intervalController.text);
    } else {
      specificTime = selectedTime;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingPopup(),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    BlocProvider.of<MedicineBloc>(context).add(
      UpdataeMedicineEvent(
        medicineId: medicineId,
        name: medicineNameController.text.trim(),
        interval: interval,
        time: specificTime,
        startDate: startDate,
        medicineAmount: int.parse(totalAmountController.text),
        medicineTaken:
            takenAmountController.text.isEmpty
                ? 0
                : int.parse(takenAmountController.text),
        lastTriggered: lastTriggered,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return BlocBuilder<MedicineBloc, MedicineState>(
      builder: (context, state) {
        if (state is! MedicineLoadedState) {
          return const Center(child: CircularProgressIndicator());
        }

        final medicine = state.medicines[medicineIndex];
        if (medicineNameController.text.isEmpty) {
          initializeControllers(medicine);
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: colors.icon),
            ),
            title: Text(
              'Edit Medicine',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.text,
              ),
            ),
            backgroundColor: colors.background,
          ),
          backgroundColor: colors.background,
          body: BlocListener<MedicineBloc, MedicineState>(
            listener: (context, state) {
              if (state is MedicineErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is MedicineLoadedState) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    color: colors.card,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.divider, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Theme.of(context).shadowColor,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomInput(
                            controller: medicineNameController,
                            hintText: 'Medicine Name',
                          ),

                          MedicineTime(
                            selectedTime: selectedTime,
                            medicineMode: medicineMode,
                            onModeChange: (newMode) {
                              medicineMode = newMode;
                            },
                            intervalController: intervalController,
                            lastTakenController: lastTakenController,
                            specificTimeCotrollers: specificTimeControllers,
                            lastTakenTime: lastTakenTime,
                          ),

                          CustomInput(
                            hintText: 'Medicine Total Amount',
                            controller: totalAmountController,
                          ),

                          CustomInput(
                            controller: takenAmountController,
                            hintText: 'Medicine Taken Amount',
                          ),

                          ElevatedButton(
                            onPressed:
                                () => handleUpdateMedicine(
                                  context,
                                  medicineNameController:
                                      medicineNameController,
                                  totalAmountController: totalAmountController,
                                  takenAmountController: takenAmountController,
                                  intervalController: intervalController,
                                  selectedTime: selectedTime,
                                  specificTimeControllers:
                                      specificTimeControllers,
                                  medicineMode: medicineMode,
                                  medicineId: medicine.medicineId,
                                  startDate: medicine.startDate,
                                  lastTriggered: medicine.lastTriggered,
                                ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              backgroundColor: colors.primaryButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Update Medicine',
                              style: TextStyle(color: colors.primaryButtonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
