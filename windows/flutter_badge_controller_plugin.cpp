#include "flutter_badge_controller_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace flutter_badge_controller {

// static
void FlutterBadgeControllerPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_badge_controller",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterBadgeControllerPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterBadgeControllerPlugin::FlutterBadgeControllerPlugin() {
  CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  CoCreateInstance(CLSID_TaskbarList, nullptr, CLSCTX_ALL,
                   IID_PPV_ARGS(&taskbar_list_));
  if (taskbar_list_) {
    taskbar_list_->HrInit();
  }
}

FlutterBadgeControllerPlugin::~FlutterBadgeControllerPlugin() {
  CoUninitialize();
}

void FlutterBadgeControllerPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else if (method_call.method_name().compare("setBadge") == 0) {
    int count = std::get<int>(*method_call.arguments());

    if (taskbar_list_ && main_window_handle_) {
      if (count > 0) {
        // Simulasi badge: tampilkan progress indeterminate
        taskbar_list_->SetProgressState(main_window_handle_, TBPF_INDETERMINATE);
      } else {
        // Hapus badge
        taskbar_list_->SetProgressState(main_window_handle_, TBPF_NOPROGRESS);
      }
    }
    result->Success();
  }else if (method_call.method_name().compare("clearBadge") == 0) {
    if (taskbar_list_ && main_window_handle_) {
      taskbar_list_->SetProgressState(main_window_handle_, TBPF_NOPROGRESS);
    }
    result->Success();
  } else {
    result->NotImplemented();
  }
}

}  // namespace flutter_badge_controller
