package com.adinn.recce.measurement.types

/** Tri-state: never assume a capability that has not been verified. */
enum class Capability { SUPPORTED, UNSUPPORTED, UNKNOWN }

/** Result of the ARCore availability check on this device. */
enum class ArCoreStatus {
    SUPPORTED_INSTALLED,
    SUPPORTED_NOT_INSTALLED,
    SUPPORTED_APK_TOO_OLD,
    UNSUPPORTED_DEVICE,
    UNKNOWN,
}

/**
 * What this specific device can do. ARCore/Depth support differs between phones, so the
 * measurement flow must consult this before relying on any capability.
 * Plane detection is intentionally not a required capability.
 */
data class DeviceCapabilities(
    val arCore: ArCoreStatus = ArCoreStatus.UNKNOWN,
    /** ARCore Depth API. Needs an ARCore Session to verify; UNKNOWN until then. */
    val depth: Capability = Capability.UNKNOWN,
) {
    companion object {
        fun unknown() = DeviceCapabilities()
    }
}
