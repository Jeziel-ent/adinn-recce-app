package com.adinn.recce.bridge

import com.adinn.recce.measurement.arcore.ArCoreCapabilityDetector
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

/**
 * React Native <-> Kotlin boundary. Thin by design: UI asks questions, the
 * :measurement-engine module answers. No measurement logic lives here.
 */
class MeasurementEngineModule(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName() = NAME

    @ReactMethod
    fun getEngineInfo(promise: Promise) {
        val map = Arguments.createMap().apply {
            putString("engineVersion", "0.0.1-foundation")
            putBoolean("measurementImplemented", false)
        }
        promise.resolve(map)
    }

    @ReactMethod
    fun getDeviceCapabilities(promise: Promise) {
        try {
            val caps = ArCoreCapabilityDetector.detect(reactApplicationContext)
            val map = Arguments.createMap().apply {
                putString("arCore", caps.arCore.name)
                putString("depth", caps.depth.name)
            }
            promise.resolve(map)
        } catch (e: Exception) {
            promise.reject("CAPABILITY_CHECK_FAILED", e.message, e)
        }
    }

    companion object {
        const val NAME = "MeasurementEngine"
    }
}
