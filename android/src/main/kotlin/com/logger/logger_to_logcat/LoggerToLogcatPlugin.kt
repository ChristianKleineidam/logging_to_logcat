package com.logger.logger_to_logcat

import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** LoggerToLogcatPlugin */
class LoggerToLogcatPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "logger_to_logcat")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "log" && call.arguments is List<*>) {
      val args = call.arguments as List<*>
      if (args[0] is String && args[1] is String && args[2] is String) {
        val level: String = args[0] as String
        val message: String = args[1] as String
        val name: String = args[2] as String

        when (level) {
          "SHOUT" -> Log.e(name, message)
          "SEVERE" -> Log.e(name, message)
          "WARNING" -> Log.w(name, message)
          "INFO" -> Log.i(name, message)
          "CONFIG" -> Log.d(name, message)
          "FINE" -> Log.v(name, message)
          "FINER" -> Log.v(name, message)
          "FINEST" -> Log.v(name, message)

          else -> { // Note the block
            Log.e(name, "$level is not a support log-level")
            result.notImplemented()
          }
        }
      } else {
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
