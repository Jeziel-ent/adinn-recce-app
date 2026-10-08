import '../models/measurement_engine_info.dart';
import '../platform/measurement_channel.dart';

/// Typed facade over the native Kotlin measurement engine.
/// Dart only presents results; all measurement logic lives in Kotlin.
class MeasurementEngine {
  MeasurementEngine([MeasurementChannel? channel])
      : _channel = channel ?? MeasurementChannel();

  final MeasurementChannel _channel;

  Future<MeasurementEngineInfo> getEngineInfo() async =>
      MeasurementEngineInfo.fromMap(await _channel.getEngineInfo());

  Future<DeviceCapabilities> getDeviceCapabilities() async =>
      DeviceCapabilities.fromMap(await _channel.getDeviceCapabilities());
}
