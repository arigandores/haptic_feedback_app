import 'package:flutter/material.dart';
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
  bool _hasAmplitudeControl = false;
  bool _hasCustomVibrationsSupport = false;

  Future<void> _checkVibrationSupport() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    bool? hasAmplitudeControl = await Vibration.hasAmplitudeControl();
    bool? hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport();

    setState(() {
      _hasVibrator = hasVibrator ?? false;
      _hasAmplitudeControl = hasAmplitudeControl ?? false;
      _hasCustomVibrationsSupport = hasCustomVibrationsSupport ?? false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vibrator: $_hasVibrator\n'
            'Amplitude Control: $_hasAmplitudeControl\n'
            'Custom Vibrations: $_hasCustomVibrationsSupport',
          ),
        ),
      );
    }
  }

  Future<void> _vibrate(
      {int? duration, int? amplitude, List<int>? pattern}) async {
    if (!_hasVibrator) return;

    if (pattern != null) {
      if (_hasCustomVibrationsSupport) {
        await Vibration.vibrate(pattern: pattern);
      } else {
        // Fallback for devices without custom vibration support
        await Vibration.vibrate(duration: pattern.reduce((a, b) => a + b));
      }
    } else if (duration != null) {
      if (_hasAmplitudeControl && amplitude != null) {
        await Vibration.vibrate(duration: duration, amplitude: amplitude);
      } else {
        // Fallback for devices without amplitude control
        await Vibration.vibrate(duration: duration);
      }
    }
  }

  // iOS-style haptic feedback implementations
  void _notificationSuccess() {
    _vibrate(
      duration: 60,
      amplitude: _hasAmplitudeControl ? 20 : null,
      pattern: _hasCustomVibrationsSupport ? [0, 10, 140, 20] : null,
    );
  }

  void _notificationWarning() {
    _vibrate(
      duration: 60,
      amplitude: _hasAmplitudeControl ? 20 : null,
      pattern: _hasCustomVibrationsSupport ? [0, 20, 140, 10] : null,
    );
  }

  void _notificationError() {
    _vibrate(
      duration: 60,
      amplitude: _hasAmplitudeControl ? 20 : null,
      pattern:
          _hasCustomVibrationsSupport ? [0, 40, 80, 30, 80, 20, 80, 10] : null,
    );
  }

  void _impactLight() {
    _vibrate(
      duration: 20,
      amplitude: _hasAmplitudeControl ? 50 : null,
    );
  }

  void _impactMedium() {
    _vibrate(
      duration: 25,
      amplitude: _hasAmplitudeControl ? 80 : null,
    );
  }

  void _impactHeavy() {
    _vibrate(
      duration: 30,
      amplitude: _hasAmplitudeControl ? 110 : null,
    );
  }

  void _impactRigid() {
    _vibrate(
      duration: 20,
      amplitude: _hasAmplitudeControl ? 180 : null,
    );
  }

  void _impactSoft() {
    _vibrate(
      duration: 30,
      amplitude: _hasAmplitudeControl ? 60 : null,
    );
  }

  void _selectionClick() {
    _vibrate(
      duration: 15,
      amplitude: _hasAmplitudeControl ? 15 : null,
    );
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
