import 'package:flutter/material.dart';
import 'package:flutter_badge_controller/flutter_badge_controller.dart';

/// Example app demonstrating usage of `flutter_badge_controller`.
///
/// This simple Flutter app shows how to:
/// - Set the app icon badge count
/// - Clear the app icon badge
///
/// The app consists of two buttons:
/// 1. "Set Badge to 5" → sets the badge count to 5.
/// 2. "Clear Badge" → resets the badge count to 0.
///
/// Supports both iOS and Android (with launcher restrictions on Android).
void main() {
  runApp(const MyApp());
}

/// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Button to set the badge count to 5
              ElevatedButton(
                onPressed: () async {
                  await FlutterBadgeController.setBadgeCount(5);
                },
                child: const Text("Set Badge to 5"),
              ),

              /// Button to clear the badge
              ElevatedButton(
                onPressed: () async {
                  await FlutterBadgeController.clearBadge();
                },
                child: const Text("Clear Badge"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
