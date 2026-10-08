/// Typed models for data returned by the Kotlin measurement engine.
class MeasurementEngineInfo {
  const MeasurementEngineInfo({
    required this.engineVersion,
    required this.measurementImplemented,
  });

  factory MeasurementEngineInfo.fromMap(Map<Object?, Object?> map) =>
      MeasurementEngineInfo(
        engineVersion: map['engineVersion'] as String? ?? 'unknown',
        measurementImplemented: map['measurementImplemented'] as bool? ?? false,
      );

  final String engineVersion;
  final bool measurementImplemented;
}

enum ArCoreStatus {
  supportedInstalled('SUPPORTED_INSTALLED'),
  supportedNotInstalled('SUPPORTED_NOT_INSTALLED'),
  supportedApkTooOld('SUPPORTED_APK_TOO_OLD'),
  unsupportedDevice('UNSUPPORTED_DEVICE'),
  unknown('UNKNOWN');

  const ArCoreStatus(this.wire);
  final String wire;

  static ArCoreStatus parse(String? value) => values.firstWhere(
        (s) => s.wire == value,
        orElse: () => ArCoreStatus.unknown,
      );
}

/// Tri-state: a capability is never assumed without verification.
enum Capability {
  supported('SUPPORTED'),
  unsupported('UNSUPPORTED'),
  unknown('UNKNOWN');

  const Capability(this.wire);
  final String wire;

  static Capability parse(String? value) => values.firstWhere(
        (c) => c.wire == value,
        orElse: () => Capability.unknown,
      );
}

class DeviceCapabilities {
  const DeviceCapabilities({required this.arCore, required this.depth});

  factory DeviceCapabilities.fromMap(Map<Object?, Object?> map) =>
      DeviceCapabilities(
        arCore: ArCoreStatus.parse(map['arCore'] as String?),
        depth: Capability.parse(map['depth'] as String?),
      );

  final ArCoreStatus arCore;
  final Capability depth;
}
