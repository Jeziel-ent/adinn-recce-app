package com.adinn.recce.measurement.types

import org.junit.Assert.assertEquals
import org.junit.Test

class DeviceCapabilitiesTest {
    @Test
    fun capabilitiesAreUnknownUntilVerified() {
        val caps = DeviceCapabilities.unknown()
        assertEquals(ArCoreStatus.UNKNOWN, caps.arCore)
        assertEquals(Capability.UNKNOWN, caps.depth)
    }
}
