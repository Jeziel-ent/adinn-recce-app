package com.adinn.recce.measurement.arcore

import android.content.Context
import com.adinn.recce.measurement.types.ArCoreStatus
import com.adinn.recce.measurement.types.DeviceCapabilities
import com.google.ar.core.ArCoreApk

/** Reports what the device supports. Performs no tracking or measurement. */
object ArCoreCapabilityDetector {

    fun detect(context: Context): DeviceCapabilities {
        val status = when (ArCoreApk.getInstance().checkAvailability(context)) {
            ArCoreApk.Availability.SUPPORTED_INSTALLED -> ArCoreStatus.SUPPORTED_INSTALLED
            ArCoreApk.Availability.SUPPORTED_NOT_INSTALLED -> ArCoreStatus.SUPPORTED_NOT_INSTALLED
            ArCoreApk.Availability.SUPPORTED_APK_TOO_OLD -> ArCoreStatus.SUPPORTED_APK_TOO_OLD
            ArCoreApk.Availability.UNSUPPORTED_DEVICE_NOT_CAPABLE -> ArCoreStatus.UNSUPPORTED_DEVICE
            else -> ArCoreStatus.UNKNOWN
        }
        // Depth support can only be verified with a Session (isDepthModeSupported); added with the POC.
        return DeviceCapabilities(arCore = status)
    }
}
