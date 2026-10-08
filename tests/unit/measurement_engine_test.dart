import 'package:adinn_recce_app/models/measurement_engine_info.dart';
import 'package:adinn_recce_app/platform/measurement_channel.dart';
import 'package:adinn_recce_app/screens/home_screen.dart';
import 'package:adinn_recce_app/services/measurement_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel(MeasurementChannel.channelName);

  void mockNative(Future<Object?> Function(MethodCall) handler) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, handler);
  }

  tearDown(() => mockNative((_) async => null));

  test('channel name is stable', () {
    expect(MeasurementChannel.channelName, 'com.adinn.recce/measurement_engine');
  });

  test('parses engine info and capabilities from native maps', () async {
    mockNative((call) async {
      switch (call.method) {
        case 'getEngineInfo':
          return {'engineVersion': 'x', 'measurementImplemented': false};
        case 'getDeviceCapabilities':
          return {'arCore': 'SUPPORTED_INSTALLED', 'depth': 'UNKNOWN'};
      }
      return null;
    });
    final engine = MeasurementEngine();
    final info = await engine.getEngineInfo();
    final caps = await engine.getDeviceCapabilities();
    expect(info.engineVersion, 'x');
    expect(info.measurementImplemented, isFalse);
    expect(caps.arCore, ArCoreStatus.supportedInstalled);
    expect(caps.depth, Capability.unknown);
  });

  test('unrecognised native values fall back to UNKNOWN, never assumed', () {
    final caps = DeviceCapabilities.fromMap({'arCore': 'WAT', 'depth': null});
    expect(caps.arCore, ArCoreStatus.unknown);
    expect(caps.depth, Capability.unknown);
  });

  testWidgets('placeholder screen shows title and Initializing status',
      (tester) async {
    mockNative((call) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      return null;
    });
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text('Adinn Recce Measurement'), findsOneWidget);
    expect(find.text('Accuracy-First Spatial Measurement POC'), findsOneWidget);
    expect(find.text('Measurement Engine'), findsOneWidget);
    expect(find.text('Status: Initializing'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
