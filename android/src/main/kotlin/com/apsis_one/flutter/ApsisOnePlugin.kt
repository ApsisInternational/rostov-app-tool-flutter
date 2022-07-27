package com.apsis_one.flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.apsis.android.apsisone.ApsisCallback
import com.apsis.android.apsisone.ApsisOne
import com.apsis.android.apsisone.integration.LocationFrequency
import com.apsis.android.apsisone.util.ApsisUtils
import com.apsis.android.apsisone.util.LogLevel
import com.apsis.android.apsisone.util.Logger
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ApsisOnePlugin */
class ApsisOnePlugin: FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var apiChannel : MethodChannel
  private lateinit var consentChannel : EventChannel
  private var eventSink : EventChannel.EventSink? = null
  private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    apiChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.apsis.one/publicapi")
    apiChannel.setMethodCallHandler(this)
    consentChannel = EventChannel(flutterPluginBinding.binaryMessenger, "com.apsis.one/consents")
    consentChannel.setStreamHandler(this)
    if(flutterPluginBinding.platformViewRegistry.registerViewFactory("ApsisContextualView", ContextualViewFactory()) == true) {
      Logger.i("View factory registered successfully")
    } else {
      Logger.w("Error while registering view factory")
    }
    Logger.i("Flutter plugin attached to engine")
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "setMinimumLogLevel") {
      call.argument<Int>("logLevel")?.let { lvl ->
        LogLevel.getByValue(lvl)?.let { ApsisOne.setMinimumLogLevel(it) }
        result.success(null)
      } ?: run {
        result.error("1", "Need logLevel parameter", null)
      }
    } else if (call.method == "provideConsent") {
      call.argument<Int>("consentType")?.let { consentType ->
        when (consentType) {
          0 -> {
            ApsisOne.collectDataEnabled(true)
            result.success(null)
          }
          1 -> {
            ApsisOne.collectLocationEnabled(true)
            result.success(null)
          }
          else ->
            result.error("3", "Wrong consentType parameter", null)
        }
      } ?: run {
        result.error("2", "Need consentType parameter", null)
      }
    } else if (call.method == "removeConsent") {
      call.argument<Int>("consentType")?.let { consentType ->
        when (consentType) {
          0 -> {
            ApsisOne.collectDataEnabled(false)
            result.success(null)
          }
          1 -> {
            ApsisOne.collectLocationEnabled(false)
            result.success(null)
          }
          else ->
            result.error("5", "Wrong consentType parameter", null)
        }
      } ?: run {
        result.error("4", "Need consentType parameter", null)
      }
    } else if (call.method == "trackScreenViewEvent") {
      call.argument<String>("event")?.let { event ->
        activity?.let { ApsisOne.trackScreenViewEvent(event, it) }
      } ?: run {
        result.error("6", "Need event parameter", null)
      }
    } else if (call.method == "trackCustomEvent") {
      call.argument<String>("eventId")?.let { eventId ->
        call.argument<HashMap<String, Any>>("data")?.let { data ->
          ApsisOne.trackCustomEvent(eventId, ApsisUtils.fromJson<JsonObject>(data.toString()))
        } ?: run {
          result.error("8", "Need data parameter", null)
        }
      } ?: run {
        result.error("7", "Need eventId parameter", null)
      }
    } else if (call.method == "trackLocation") {
      call.argument<Double>("latitude")?.let { latitude ->
        call.argument<Double>("longitude")?.let { longitude ->
          call.argument<String>("placemarkName")?.let { placemarkName ->
            call.argument<String>("placemarkAddress")?.let { placemarkAddress ->
              call.argument<Int>("accuracy")?.let { accuracy ->
                ApsisOne.trackLocation(latitude, longitude, placemarkName, placemarkAddress, accuracy.toDouble())
              } ?: run {
                result.error("13", "Need accuracy parameter", null)
              }
            } ?: run {
              result.error("12", "Need placemarkAddress parameter", null)
            }
          } ?: run {
            result.error("11", "Need placemarkName parameter", null)
          }
        } ?: run {
          result.error("10", "Need longitude parameter", null)
        }
      } ?: run {
        result.error("9", "Need latitude parameter", null)
      }
    } else if (call.method == "startCollectingLocation") {
      call.argument<Int>("frequency")?.let { frequency ->
        LocationFrequency.getByValue(frequency)?.let { freq ->
          activity?.let { ApsisOne.startCollectingLocation(freq, it) }
        } ?: run {
          result.error("15", "Need frequency parameter", null)
        }
      } ?: run {
        result.error("14", "Need frequency parameter", null)
      }
    } else if (call.method == "stopCollectingLocation") {
      ApsisOne.stopCollectingLocation()
    } else if (call.method == "subscribeOnConsentLost") {
      call.argument<Int>("consentType")?.let { consentType ->
        ApsisOne.subscribeCollectDataConsentLost(object : ApsisCallback {
          override fun receive(topic: String, payload: JsonElement) {
            eventSink?.success(consentType)
          }
        })
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    apiChannel.setMethodCallHandler(null)
    consentChannel.setStreamHandler(null)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
