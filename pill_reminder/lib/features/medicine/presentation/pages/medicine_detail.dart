import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/icon_and_info.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/edit_medicine_page.dart';
import 'package:provider/provider.dart';

class MedicineDetail extends StatelessWidget {
  static const String routeName = '/medicine-detail';
  const MedicineDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    final index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: colors.text),
        ),
        title: Text(
          'Medicine Detail',
          style: TextStyle(
            color: colors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocBuilder<MedicineBloc, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoadedState) {
            final medicine = state.medicines[index];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [colors.gradientStart, colors.gradientEnd],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: colors.buttonShadow,
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colors.glassBackground,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: colors.glassBorder,
                                      width: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(24.0),
                                  child: Icon(
                                    Icons.health_and_safety,
                                    size: 80,
                                    color: colors.primaryButtonText,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.glassBackground,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: colors.glassBorder,
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.cardShadow,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: colors.primaryButtonText,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            medicine.name,
                            style: TextStyle(
                              color: colors.primaryButtonText,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: TextStyle(
                                    color: colors.primaryButtonText.withOpacity(
                                      0.8,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.glassBackground,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colors.glassBorder,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    '${medicine.startDate.difference(DateTime.now()).inDays + 1} Day${medicine.startDate.difference(DateTime.now()).inDays + 1 == 1 ? '' : 's'}',
                                    style: TextStyle(
                                      color: colors.primaryButtonText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: LinearProgressIndicator(
                                value:
                                    (medicine.medicineTaken * 100) /
                                    medicine.medicineAmount /
                                    100,
                                backgroundColor: colors.progressBackground,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colors.progressColor,
                                ),
                                minHeight: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.card,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: colors.cardShadow,
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          IconsAndInfo(
                            icons: Icons.medication_sharp,
                            title: 'Total Amount',
                            info: '${medicine.medicineAmount} pills',
                          ),
                          IconsAndInfo(
                            icons: Icons.check_circle,
                            title: 'Taken Amount',
                            info: '${medicine.medicineTaken} pills',
                          ),
                          IconsAndInfo(
                            icons: Icons.medical_services,
                            title: 'Remaining Amount',
                            info:
                                '${medicine.medicineAmount - medicine.medicineTaken} pills',
                          ),
                          IconsAndInfo(
                            icons: Icons.calendar_month,
                            title: 'Start Date',
                            info:
                                '${medicine.startDate.day}/${medicine.startDate.month}/${medicine.startDate.year}',
                          ),
                          if (medicine.interval != null)
                            IconsAndInfo(
                              icons: Icons.timer,
                              title: 'Interval',
                              info: 'Every ${medicine.interval} hours',
                            ),
                          if (medicine.time != null &&
                              medicine.time!.isNotEmpty)
                            IconsAndInfo(
                              icons: Icons.access_time,
                              title: 'Specific Times',
                              info: medicine.time!
                                  .map((t) => '${t.hour}:${t.minute}')
                                  .join(', '),
                            ),
                          IconsAndInfo(
                            icons: Icons.timer_outlined,
                            title: 'Last Taken',
                            info:
                                '${medicine.lastTriggered.hour}:${medicine.lastTriggered.minute}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          EditMedicinePage.routeName,
                          arguments: index,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: colors.primaryButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: colors.buttonShadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: colors.primaryButtonText),
                          const SizedBox(width: 12),
                          Text(
                            'Edit Medicine',
                            style: TextStyle(
                              color: colors.primaryButtonText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
