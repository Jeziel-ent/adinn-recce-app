import { NativeModules } from 'react-native';
import type { DeviceCapabilities, EngineInfo } from '../types/measurementEngine';

interface MeasurementEngineNative {
  getEngineInfo(): Promise<EngineInfo>;
  getDeviceCapabilities(): Promise<DeviceCapabilities>;
}

/** Typed wrapper over the Kotlin `MeasurementEngine` native module. */
export const MeasurementEngine: MeasurementEngineNative | undefined =
  NativeModules.MeasurementEngine;
