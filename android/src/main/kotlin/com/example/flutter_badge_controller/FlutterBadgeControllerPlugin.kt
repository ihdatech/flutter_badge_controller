package com.example.flutter_badge_controller

import android.app.NotificationManager
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterBadgeControllerPlugin */
class FlutterBadgeControllerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private var badgeCount: Int = 0

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_badge_controller")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    when (call.method) {
      "setBadgeCount" -> {
        val count = call.argument<Int>("count") ?: 0
        setBadge(count)
        result.success(null)
      }
      "clearBadge" -> {
        setBadge(0)
        result.success(null)
      }
      "getBadgeCount" -> {
        result.success(badgeCount)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun setBadge(count: Int) {
    badgeCount = count
    try {
      val launcherClassName = getLauncherClassName(context)
      if (launcherClassName != null) {
        val intent = android.content.Intent("android.intent.action.BADGE_COUNT_UPDATE")
        intent.putExtra("badge_count", count)
        intent.putExtra("badge_count_package_name", context.packageName)
        intent.putExtra("badge_count_class_name", launcherClassName)
        context.sendBroadcast(intent)
      }
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }

  private fun getLauncherClassName(context: Context): String? {
    val pm = context.packageManager
    val intent = pm.getLaunchIntentForPackage(context.packageName) ?: return null
    return intent.component?.className
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
