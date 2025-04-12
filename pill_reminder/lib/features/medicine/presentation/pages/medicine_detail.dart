import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/icon_and_info.dart';
import 'package:provider/provider.dart';

class MedicineDetail extends StatelessWidget {
  static const String routeName = '/medicine-detail';
  const MedicineDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: colors.text,
          ),
        ),
        title: Text(
          'Medicine Detail',
          style: TextStyle(color: colors.text),
        ),
        backgroundColor: colors.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: colors.card,
                shadowColor: colors.shadow,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: colors.divider,
                  ),
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
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.health_and_safety,
                              size: 80,
                              color: colors.primaryButtonText,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
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
                              style: TextStyle(color: colors.primaryButtonText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Amoxa',
                      style: TextStyle(
                          color: colors.text,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20),
                      decoration: BoxDecoration(
                        color: colors.primaryButton,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Antibiotics',
                        style: TextStyle(color: colors.primaryButtonText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
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
                            '9 Days',
                            style: TextStyle(
                              color: colors.primaryButton,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: colors.progressBackground,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.progressColor,
                        ),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: colors.internalCard,
                              elevation: 10,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      'Remaining pills',
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '20',
                                    style: TextStyle(
                                      color: colors.text,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 8.0),
                                    child: LinearProgressIndicator(
                                      value: 0.5,
                                      borderRadius: BorderRadius.circular(20),
                                      backgroundColor:
                                          colors.progressBackground,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        colors.progressColor,
                                      ),
                                      minHeight: 5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: colors.internalCard,
                              elevation: 10,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      'Remaining days',
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '15',
                                    style: TextStyle(
                                      color: colors.text,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 8.0),
                                    child: LinearProgressIndicator(
                                      value: 0.5,
                                      borderRadius: BorderRadius.circular(20),
                                      backgroundColor:
                                          colors.progressBackground,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        colors.progressColor,
                                      ),
                                      minHeight: 5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: colors.card,
                shadowColor: colors.shadow,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: colors.divider,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconsAndInfo(
                      icons: Icons.timer,
                      title: 'Next dose',
                      info: '8:00 AM',
                    ),
                    IconsAndInfo(
                        icons: Icons.rule,
                        title: 'Instruction',
                        info: 'Take before food'),
                    IconsAndInfo(
                      icons: Icons.medication_sharp,
                      title: 'Dosage',
                      info: '500 mg',
                    ),
                    IconsAndInfo(
                      icons: Icons.calendar_month_sharp,
                      title: 'Taken Days',
                      info: '41',
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
                        // Add your action here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: colors.primaryButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.edit,
                            color: colors.primaryButtonText,
                          ),
                          Text(
                            'Edit Medicine',
                            style: TextStyle(color: colors.primaryButtonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Add your action here
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: colors.error,
                        ),
                        foregroundColor: colors.primaryButton,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.delete,
                            color: colors.error,
                          ),
                          Text(
                            'Delete Medicine',
                            style: TextStyle(
                              color: colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
