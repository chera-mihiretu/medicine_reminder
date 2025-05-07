import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/data/models/medicine_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MedicineTaken extends StatefulWidget {
  static const routeName = '/medicine-taken';
  const MedicineTaken({super.key});

  @override
  State<MedicineTaken> createState() => _MedicineTakenState();
}

class _MedicineTakenState extends State<MedicineTaken>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicine =
        ModalRoute.of(context)!.settings.arguments as MedicineModel;
    final isCompleted = medicine.medicineTaken >= medicine.medicineAmount;
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.background,
        title: Text(
          'Medicine Taken',
          style: TextStyle(
            color: colors.text,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.background, colors.background.withOpacity(0.95)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: colors.glassBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: colors.cardShadow,
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Icon(
                      isCompleted ? Icons.celebration : Icons.check_circle,
                      color:
                          isCompleted ? colors.success : colors.primaryButton,
                      size: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  isCompleted ? 'Congratulations!' : 'Well Done!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? colors.success : colors.primaryButton,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.glassBorder, width: 1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'You\'ve taken ${medicine.name}',
                        style: TextStyle(
                          fontSize: 18,
                          color: colors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Amount: ${medicine.medicineAmount}',
                        style: TextStyle(fontSize: 16, color: colors.greyText),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total taken: ${medicine.medicineTaken} times',
                        style: TextStyle(fontSize: 16, color: colors.greyText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (isCompleted)
                  Lottie.asset(
                    'assets/animations/celebration.json',
                    width: 240,
                    height: 240,
                    repeat: true,
                  )
                else
                  Lottie.asset(
                    'assets/animations/continue.json',
                    width: 240,
                    height: 240,
                    repeat: true,
                  ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colors.glassBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.glassBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: colors.cardShadow,
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    isCompleted
                        ? 'You\'ve completed your medicine course!'
                        : 'Keep up the good work!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          isCompleted ? colors.success : colors.primaryButton,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
