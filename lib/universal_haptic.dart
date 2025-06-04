import 'dart:io';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Provides consistent haptic feedback across Android and iOS devices.
class UniversalHaptic {
  static Future<void> _vibrate({int duration = 40}) async {
    final hasVibrator = await Vibration.hasVibrator();
    if (Platform.isAndroid && hasVibrator) {
      await Vibration.vibrate(duration: duration);
    } else {
      await HapticFeedback.vibrate();
    }
  }

  static Future<void> lightImpact() => _vibrate(duration: 20);
  static Future<void> mediumImpact() => _vibrate(duration: 40);
  static Future<void> heavyImpact() => _vibrate(duration: 60);
  static Future<void> selectionClick() => HapticFeedback.selectionClick();
}
