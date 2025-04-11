import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
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
      body: Column(
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
                              color: colors.error,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.health_and_safety,
                            size: 80,
                            color: colors.icon,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: colors.primaryButton,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(color: colors.text),
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
                      style: TextStyle(color: colors.text),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Course Progress',
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
                      backgroundColor: colors.greyText,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colors.primaryButton,
                      ),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
