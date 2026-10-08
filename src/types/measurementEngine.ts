export type ArCoreStatus =
  | 'SUPPORTED_INSTALLED'
  | 'SUPPORTED_NOT_INSTALLED'
  | 'SUPPORTED_APK_TOO_OLD'
  | 'UNSUPPORTED_DEVICE'
  | 'UNKNOWN';

export type Capability = 'SUPPORTED' | 'UNSUPPORTED' | 'UNKNOWN';

export interface EngineInfo {
  engineVersion: string;
  measurementImplemented: boolean;
}

export interface DeviceCapabilities {
  arCore: ArCoreStatus;
  depth: Capability;
}
