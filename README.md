# Haptic Feedback App

A Flutter application that delivers consistent haptic feedback on both Android and iOS devices. The app automatically falls back to basic vibration when advanced features are unavailable.

## Features

### Notification Feedback
- Success: Short, crisp feedback for successful actions
- Warning: Medium-duration alert pattern
- Error: Strong, attention-grabbing pattern

### Impact Feedback
- Light: Gentle tap sensation
- Medium: Moderate impact feedback
- Heavy: Strong impact feedback
- Rigid: Sharp, quick pulses
- Soft: Gentle, smooth pulses

### Selection Feedback
- Click: Quick, light feedback for selection events

## Device Compatibility

The app automatically detects device capabilities and adjusts the haptic feedback accordingly:

- For devices with amplitude control: Uses varying vibration intensities
- For devices without amplitude control: Uses carefully tuned durations
- For devices with custom vibration support: Uses complex patterns
- For devices without custom vibration support: Falls back to single vibrations

## Requirements

- Android API level 21 or higher
- Device with vibration hardware support

## Installation

1. Download the latest APK from the releases section
2. Install on your Android device
3. Grant vibration permission if prompted

## Development

To build the project:

```bash
flutter pub get
flutter build apk --release
```

## License

This project is open source and available under the MIT License.
