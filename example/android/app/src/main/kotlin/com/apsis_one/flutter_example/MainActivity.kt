package com.apsis_one.flutter_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var appChannel : MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        appChannel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "com.apsis.one/sampleapp")
        appChannel.setMethodCallHandler(MethodChannel.MethodCallHandler { call, result ->
            if (call.method == "switchView") {
                // run another activity
                result.success(null)
            } else {
                result.notImplemented()
            }
        })

    }
}
