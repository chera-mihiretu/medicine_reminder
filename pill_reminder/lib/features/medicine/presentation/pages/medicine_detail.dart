import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_state.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/icon_and_info.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/edit_medicine_page.dart';
import 'package:pill_reminder/features/notification/domain/entities/notifaction_enums.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_event.dart';
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: colors.text),
        ),
        title: Text('Medicine Detail', style: TextStyle(color: colors.text)),
        backgroundColor: colors.background,
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
                    child: Card(
                      color: colors.card,
                      shadowColor: colors.shadow,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colors.primaryButton,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.health_and_safety,
                                    size: 80,
                                    color: colors.primaryButtonText,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5.0,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.shadow,
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                      ),
                                    ],
                                    color: colors.primaryButton,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: colors.primaryButtonText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            medicine.name,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress',
                                  style: TextStyle(
                                    color: colors.greyText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '${DateTime.now().difference(medicine.startDate).inDays} Days',
                                  style: TextStyle(
                                    color: colors.primaryButton,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: LinearProgressIndicator(
                              value:
                                  (medicine.medicineTaken * 100) /
                                  medicine.medicineAmount /
                                  100,
                              backgroundColor: colors.progressBackground,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colors.progressColor,
                              ),
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: colors.card,
                      shadowColor: colors.shadow,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<NotificationBloc>().add(
                                ShowNotificationEvent(
                                  id: int.parse(
                                    state.medicines[index].medicineId,
                                  ),
                                  title: state.medicines[index].name,
                                  body: 'Time to take your medicine',
                                  payload: state.medicines[index].medicineId,
                                  scheduledTime: DateTime.now().add(
                                    const Duration(seconds: 10),
                                  ),
                                  isRecurring: false,
                                  priority: MyPriority.high,
                                  importance: MyImportance.high,
                                  channelId: 'medication_channel_01',
                                  channelName: 'Medication Reminders',
                                  sound: 'default',
                                ),
                              );
                            },
                            child: Text('Trigger'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                EditMedicinePage.routeName,
                                arguments: index,
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: colors.primaryButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: colors.primaryButtonText,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Edit Medicine',
                                  style: TextStyle(
                                    color: colors.primaryButtonText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
