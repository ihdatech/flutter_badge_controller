import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_badge_controller/flutter_badge_controller_platform_interface.dart';

/// Implementation of [FlutterBadgeControllerPlatform] using [MethodChannel].
///
/// This class communicates with the native platform (Android/iOS)
/// through the `flutter_badge_controller` method channel.
///
/// - On **iOS**, it uses:
///   - `UIApplication.shared.applicationIconBadgeNumber`
///
/// - On **Android**, it sends a broadcast intent (`android.intent.action.BADGE_COUNT_UPDATE`)
///   which is supported by many OEM launchers (Samsung, Huawei, Xiaomi, etc.).
///   Note: Not all Android launchers support app icon badges.
///
/// Example:
/// ```dart
/// await FlutterBadgeController.setBadgeCount(5);   // show badge "5"
/// await FlutterBadgeController.getBadgeCount();    // returns 5
/// await FlutterBadgeController.clearBadge();       // reset badge to 0
/// ```
class MethodChannelFlutterBadgeController
    extends FlutterBadgeControllerPlatform {
  /// The method channel used to communicate with native code.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_badge_controller');

  /// Clears the app icon badge (sets it to 0).
  ///
  /// Does nothing if the current platform is not Android or iOS.
  @override
  Future<void> clearBadge() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await methodChannel.invokeMethod('clearBadge');
  }

  /// Gets the current badge count from the app icon.
  ///
  /// Returns `0` if the platform is not Android or iOS,
  /// or if badge count is not supported.
  @override
  Future<int?> getBadgeCount() async {
    if (!Platform.isAndroid && !Platform.isIOS) return 0;
    final result = await methodChannel.invokeMethod<int>('getBadgeCount');
    return result;
  }

  /// Sets the app icon badge count.
  ///
  /// [count] must be a non-negative integer.
  /// - On iOS: requires notification permission with `.badge` enabled.
  /// - On Android: works only on supported OEM launchers.
  ///
  /// Does nothing if the current platform is not Android or iOS.
  @override
  Future<void> setBadgeCount(int count) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await methodChannel.invokeMethod('setBadgeCount', {"count": count});
  }
}
