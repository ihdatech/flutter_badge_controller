/// Flutter Badge Controller
///
/// This is the main entry point for the `flutter_badge_controller` plugin.
/// It provides a simple API to set, get, and clear the app icon badge.
///
/// Example usage:
/// ```dart
/// import 'package:flutter_badge_controller/flutter_badge_controller.dart';
///
/// await FlutterBadgeController.setBadgeCount(5);   // show badge "5"
/// await FlutterBadgeController.getBadgeCount();    // returns 5
/// await FlutterBadgeController.clearBadge();       // reset badge to 0
/// ```
library;

export 'flutter_badge_controller_method_channel.dart';
export 'flutter_badge_controller_platform_interface.dart';

import 'flutter_badge_controller_platform_interface.dart';

/// High-level static API to manage app icon badge.
///
/// This facade delegates calls to the platform-specific implementation
/// ([FlutterBadgeControllerPlatform.instance]).
class FlutterBadgeController {
  /// Set the app icon badge count to [count].
  static Future<void> setBadgeCount(int count) =>
      FlutterBadgeControllerPlatform.instance.setBadgeCount(count);

  /// Clear the app icon badge (set to 0).
  static Future<void> clearBadge() =>
      FlutterBadgeControllerPlatform.instance.clearBadge();

  /// Get the current badge count.
  static Future<int?> getBadgeCount() =>
      FlutterBadgeControllerPlatform.instance.getBadgeCount();
}
