package com.logger.logging_to_logcat

import android.util.Log
import androidx.annotation.NonNull
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.IOException
import java.util.concurrent.Executors
import io.flutter.plugin.common.EventChannel

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler

/** LoggerToLogcatPlugin */
class LoggingToLogcatPlugin: FlutterPlugin, MethodCallHandler, StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private var eventSink: EventSink? = null
  private var logcatProcess: Process? = null
  private val uiHandler: Handler = Handler(Looper.getMainLooper())
  private val executor = Executors.newSingleThreadExecutor()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "logging_to_logcat")
    channel.setMethodCallHandler(this)
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "logging_to_logcat/events")
    eventChannel.setStreamHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "log" -> {
        if (call.arguments is List<*>) {
          val args = call.arguments as List<*>
          if (args[0] is String && args[1] is String && args[2] is String) {
            val level = args[0] as String
            val message = args[1] as String
            val name = args[2] as String
            when (level) {
              "SHOUT", "SEVERE" -> Log.e(name, message)
              "WARNING" -> Log.w(name, message)
              "INFO" -> Log.i(name, message)
              "CONFIG" -> Log.d(name, message)
              "FINE", "FINER", "FINEST" -> Log.v(name, message)
              else -> {
                Log.e(name, "$level is not a support log-level")
                result.notImplemented()
                return
              }
            }
            result.success(null)
          } else {
            result.notImplemented()
          }
        } else {
          result.notImplemented()
        }
      }
      "startMonitor" -> {
        val options: String = call.argument<String>("options") ?: ""
        closePrevious()
        logcatMonitorThread(options)
        result.success(true)
      }
      "stopMonitor" -> {
        closePrevious()
        result.success(true)
      }
      "runLogcat" -> {
        val options: String = call.argument<String>("options") ?: ""
        val log = StringBuffer()
        try {
          val cmd = "logcat $options"
          val process = Runtime.getRuntime().exec(cmd)
          val reader = BufferedReader(InputStreamReader(process.inputStream))
          var line: String?
          while (reader.readLine().also { line = it } != null) {
            log.append(line)
          }
        } catch (e: IOException) {
          log.append("EXCEPTION" + e.toString())
        }
        result.success(log.toString())
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
    closePrevious()
  }

  override fun onListen(arguments: Any?, events: EventSink) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }

  private fun closePrevious() {
    logcatProcess?.destroyForcibly()
    logcatProcess = null
  }

  private fun logcatMonitorThread(options: String) {
    executor.execute { logcatMonitor(options) }
  }

  private fun logcatMonitor(options: String) {
    val cmd = "logcat $options"
    try {
      Log.d("LoggingToLogcatPlugin", "running command: $cmd")
      logcatProcess = Runtime.getRuntime().exec(cmd)
      val reader = BufferedReader(InputStreamReader(logcatProcess!!.inputStream))
      var line: String?
      var startTime = SystemClock.elapsedRealtime()
      while (reader.readLine().also { line = it } != null) {
        val interval = SystemClock.elapsedRealtime() - startTime
        if (interval > 1000) Thread.sleep(200)
        sendEvent(line!!)
        startTime = SystemClock.elapsedRealtime()
      }
    } catch (e: IOException) {
      sendEvent("EXCEPTION" + e.toString())
    } catch (e: InterruptedException) {
      sendEvent("logcatMonitor interrupted")
    }
    Log.d("LoggingToLogcatPlugin", "closed command: $cmd")
  }

  private fun sendEvent(message: String) {
    uiHandler.post { eventSink?.success(message) }
  }
}
