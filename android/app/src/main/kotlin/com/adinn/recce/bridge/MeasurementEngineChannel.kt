package com.adinn.recce.bridge

import android.content.Context
import com.adinn.recce.measurement.arcore.ArCoreCapabilityDetector
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Flutter <-> Kotlin boundary. Thin by design: Dart asks questions, the
 * :measurement-engine module answers. No measurement logic lives here.
 */
class MeasurementEngineChannel(private val context: Context) : MethodChannel.MethodCallHandler {

    fun register(messenger: BinaryMessenger) {
        MethodChannel(messenger, CHANNEL_NAME).setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getEngineInfo" -> result.success(
                mapOf(
                    "engineVersion" to ENGINE_VERSION,
                    "measurementImplemented" to false,
                )
            )
            "getDeviceCapabilities" -> try {
                val caps = ArCoreCapabilityDetector.detect(context)
                result.success(mapOf("arCore" to caps.arCore.name, "depth" to caps.depth.name))
            } catch (e: Exception) {
                result.error("CAPABILITY_CHECK_FAILED", e.message, null)
            }
            else -> result.notImplemented()
        }
    }

    companion object {
        const val CHANNEL_NAME = "com.adinn.recce/measurement_engine"
        const val ENGINE_VERSION = "0.0.1-foundation"
    }
}
