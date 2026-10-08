import 'package:flutter/services.dart';

/// Raw MethodChannel to the Kotlin measurement engine. Returns untyped maps;
/// use `MeasurementEngine` (services/) for typed access.
class MeasurementChannel {
  MeasurementChannel([MethodChannel? channel])
      : _channel = channel ?? const MethodChannel(channelName);

  static const String channelName = 'com.adinn.recce/measurement_engine';

  final MethodChannel _channel;

  Future<Map<Object?, Object?>> getEngineInfo() => _invoke('getEngineInfo');

  Future<Map<Object?, Object?>> getDeviceCapabilities() =>
      _invoke('getDeviceCapabilities');

  Future<Map<Object?, Object?>> _invoke(String method) async {
    final result = await _channel.invokeMapMethod<Object?, Object?>(method);
    if (result == null) {
      throw PlatformException(code: 'NULL_RESULT', message: '$method returned null');
    }
    return result;
  }
}
