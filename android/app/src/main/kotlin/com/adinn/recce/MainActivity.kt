package com.adinn.recce

import com.adinn.recce.bridge.MeasurementEngineChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MeasurementEngineChannel(applicationContext).register(flutterEngine.dartExecutor.binaryMessenger)
    }
}
