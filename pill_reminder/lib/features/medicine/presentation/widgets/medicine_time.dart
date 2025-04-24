import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/custom_input.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/medicine_mode.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MedicineTime extends StatefulWidget {
  final TextEditingController intervalController;
  final List<TextEditingController> specificTimeCotrollers;
  final List<TimeOfDay> selectedTime;
  MedicineMode medicineMode;
  final Function onModeChange;

  MedicineTime({
    super.key,
    required this.intervalController,
    required this.specificTimeCotrollers,
    this.medicineMode = MedicineMode.interval,
    required this.onModeChange,
    required this.selectedTime,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MedicineTimeState createState() => _MedicineTimeState();
}

class _MedicineTimeState extends State<MedicineTime> {
  Future<void> pickTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime[index],
    );
    if (picked != null) {
      setState(() {
        widget.selectedTime[index] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.medicineMode = MedicineMode.interval;
                  widget.onModeChange(widget.medicineMode);
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                backgroundColor:
                    (widget.medicineMode == MedicineMode.interval)
                        ? colors.primaryButton
                        : colors.disabled,
              ),
              child: Text(
                'Interval',
                style: TextStyle(color: colors.primaryButtonText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                backgroundColor:
                    (widget.medicineMode == MedicineMode.specificTime)
                        ? colors.primaryButton
                        : colors.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.medicineMode = MedicineMode.specificTime;
                  if (widget.specificTimeCotrollers.isEmpty) {
                    widget.selectedTime.add(TimeOfDay.now());

                    widget.specificTimeCotrollers.add(TextEditingController());
                  }
                  widget.onModeChange(widget.medicineMode);
                });
              },
              child: Text(
                'Time',
                style: TextStyle(color: colors.primaryButtonText),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            (widget.medicineMode == MedicineMode.interval)
                ? Column(
                  children: [
                    CustomInput(
                      controller: widget.intervalController,
                      hintText: 'Medicine Interval',
                    ),
                  ],
                )
                : Column(
                  children: [
                    ...List.generate(widget.specificTimeCotrollers.length, (
                      index,
                    ) {
                      return CustomInput(
                        controller: widget.specificTimeCotrollers[index],
                        hintText: 'Add time',
                        onTap: () async {
                          await pickTime(index);

                          int hour = widget.selectedTime[index].hour;
                          String period =
                              widget.selectedTime[index].period
                                  .toString()
                                  .split('.')
                                  .last
                                  .toUpperCase();

                          // Convert to 12-hour format
                          if (hour > 12) {
                            hour -= 12;
                          } else if (hour == 0) {
                            hour = 12;
                          }

                          widget.specificTimeCotrollers[index].text =
                              '$hour:${widget.selectedTime[index].minute.toString().padLeft(2, '0')} $period';
                        },
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            if (widget.specificTimeCotrollers.length > 1) {
                              setState(() {
                                widget.specificTimeCotrollers.removeLast();
                                widget.selectedTime.removeLast();
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: colors.primaryButton,
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 30,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Remove Time',
                            style: TextStyle(color: colors.primaryButton),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.specificTimeCotrollers.add(
                                TextEditingController(),
                              );
                              widget.selectedTime.add(TimeOfDay.now());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 30,
                            ),
                            backgroundColor:
                                (widget.medicineMode ==
                                        MedicineMode.specificTime)
                                    ? colors.primaryButton
                                    : colors.disabled,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Add Time',
                            style: TextStyle(color: colors.primaryButtonText),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          ],
        ),
      ],
    );
  }
}
