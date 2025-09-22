import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_badge_controller/flutter_badge_controller_method_channel.dart';

/// The platform interface for the `flutter_badge_controller` plugin.
///
/// This defines the contract that all platform implementations (Android, iOS, Web, etc.)
/// must follow in order to support app icon badges.
///
/// By default, [MethodChannelFlutterBadgeController] is used, which communicates
/// with the native platform via a [MethodChannel].
///
/// Platform-specific implementations should extend [FlutterBadgeControllerPlatform]
/// and set [FlutterBadgeControllerPlatform.instance] to their own class during
/// registration.
///
/// Example:
/// ```dart
/// // Set a custom implementation (e.g., web)
/// FlutterBadgeControllerPlatform.instance = MyWebFlutterBadgeController();
/// ```
abstract class FlutterBadgeControllerPlatform extends PlatformInterface {
  /// Constructs a [FlutterBadgeControllerPlatform].
  FlutterBadgeControllerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBadgeControllerPlatform _instance =
      MethodChannelFlutterBadgeController();

  /// The default instance of [FlutterBadgeControllerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBadgeController].
  static FlutterBadgeControllerPlatform get instance => _instance;

  /// Sets the active platform-specific implementation.
  ///
  /// Platform implementations (e.g., Android, iOS, Web) should call this
  /// during plugin registration.
  static set instance(FlutterBadgeControllerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Clears the app icon badge (sets it back to 0).
  ///
  /// Platform implementations must override this method.
  Future<void> clearBadge();

  /// Returns the current badge count.
  ///
  /// Platform implementations must override this method.
  Future<int?> getBadgeCount();

  /// Sets the app icon badge count to [count].
  ///
  /// Platform implementations must override this method.
  Future<void> setBadgeCount(int count);
}
