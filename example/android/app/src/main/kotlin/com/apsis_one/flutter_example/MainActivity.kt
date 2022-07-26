package com.apsis_one.flutter_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private lateinit var appChannel : MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            appChannel = MethodChannel(it, "com.apsis.one/sampleapp")
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

    /*
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        if(flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("apsisview", ApsisViewFactory2()) == true) {
            Log.i("FlutterApp", "ApsisViewFactory was registered by MainActivity")
        } else {
            Log.w("FlutterApp", "MainActivity could not register ApsisViewFactory")
        }
        super.configureFlutterEngine(flutterEngine)
    }
     */
}
