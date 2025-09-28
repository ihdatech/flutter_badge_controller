import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_badge_controller/flutter_badge_controller.dart';
import 'package:flutter_badge_controller/flutter_badge_controller_platform_interface.dart';
import 'package:flutter_badge_controller/flutter_badge_controller_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBadgeControllerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBadgeControllerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBadgeControllerPlatform initialPlatform = FlutterBadgeControllerPlatform.instance;

  test('$MethodChannelFlutterBadgeController is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBadgeController>());
  });

  test('getPlatformVersion', () async {
    FlutterBadgeController flutterBadgeControllerPlugin = FlutterBadgeController();
    MockFlutterBadgeControllerPlatform fakePlatform = MockFlutterBadgeControllerPlatform();
    FlutterBadgeControllerPlatform.instance = fakePlatform;

    expect(await flutterBadgeControllerPlugin.getPlatformVersion(), '42');
  });
}
