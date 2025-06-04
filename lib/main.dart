import 'package:flutter/material.dart';
import 'package:haptic_feedback_app/universal_haptic.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haptic Feedback Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasVibrator = false;

  Future<void> _checkVibrationSupport() async {
    bool hasVibrator = await Vibration.hasVibrator();

    if (!mounted) return;

    setState(() {
      _hasVibrator = hasVibrator;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vibrator: $_hasVibrator',
          ),
        ),
      );
    }
  }

  // Basic haptic feedback wrappers
  void _notificationSuccess() {
    UniversalHaptic.lightImpact();
  }

  void _notificationWarning() {
    UniversalHaptic.mediumImpact();
  }

  void _notificationError() {
    UniversalHaptic.heavyImpact();
  }

  void _impactLight() {
    UniversalHaptic.lightImpact();
  }

  void _impactMedium() {
    UniversalHaptic.mediumImpact();
  }

  void _impactHeavy() {
    UniversalHaptic.heavyImpact();
  }

  void _impactRigid() {
    UniversalHaptic.mediumImpact();
  }

  void _impactSoft() {
    UniversalHaptic.lightImpact();
  }

  void _selectionClick() {
    UniversalHaptic.selectionClick();
  }


  Widget _buildFeedbackButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkVibrationSupport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haptic Feedback Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSectionTitle('Notification Feedback'),
                _buildFeedbackButton('Success', _notificationSuccess),
                _buildFeedbackButton('Warning', _notificationWarning),
                _buildFeedbackButton('Error', _notificationError),
                _buildSectionTitle('Impact Feedback'),
                _buildFeedbackButton('Light', _impactLight),
                _buildFeedbackButton('Medium', _impactMedium),
                _buildFeedbackButton('Heavy', _impactHeavy),
                _buildFeedbackButton('Rigid', _impactRigid),
                _buildFeedbackButton('Soft', _impactSoft),
                _buildSectionTitle('Selection Feedback'),
                _buildFeedbackButton('Click', _selectionClick),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
