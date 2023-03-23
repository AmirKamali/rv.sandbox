package com.example.roadvault_interview_sandbox

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "rv.interview.sandbox/device")
            .setMethodCallHandler { call, result ->
                // TODO: only result the device name if the call.method is 'getDeviceName'
                result.success(getDeviceName())
            }
    }
}

private fun getDeviceName(): String {
    return android.os.Build.MODEL
}
