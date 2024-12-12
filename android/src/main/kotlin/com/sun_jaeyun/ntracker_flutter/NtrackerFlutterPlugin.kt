package com.sun_jaeyun.ntracker_flutter

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.navercorp.ntracker.ntrackersdk.NTrackerExt
import com.navercorp.ntracker.ntrackersdk.NTrackerExtPhase

/** NtrackerFlutterPlugin */
class NtrackerFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ntracker_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "initialize") {
      val args = call.arguments as? Map<String, Any>
      if (args == null) {
        result.error("INVALID_ARGUMENT", "Expected a Map parameter", null)
        return
      }

      val siteId = args["siteId"] as String
      val debug = args["debug"] as Boolean

      NTrackerExt.enableDebugLog(debug)
      NTrackerExt.configure(
        applicationContext,
        siteId,
        if (debug) NTrackerExtPhase.DEBUG else NTrackerExtPhase.RELEASE
      )

      result.success(true)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
