#include "include/flutter_badge_controller/flutter_badge_controller_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_badge_controller_plugin.h"

void FlutterBadgeControllerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_badge_controller::FlutterBadgeControllerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
