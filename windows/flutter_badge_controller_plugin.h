#ifndef FLUTTER_PLUGIN_FLUTTER_BADGE_CONTROLLER_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_BADGE_CONTROLLER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_badge_controller {

class FlutterBadgeControllerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterBadgeControllerPlugin();

  virtual ~FlutterBadgeControllerPlugin();

  // Disallow copy and assign.
  FlutterBadgeControllerPlugin(const FlutterBadgeControllerPlugin&) = delete;
  FlutterBadgeControllerPlugin& operator=(const FlutterBadgeControllerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_badge_controller

#endif  // FLUTTER_PLUGIN_FLUTTER_BADGE_CONTROLLER_PLUGIN_H_
