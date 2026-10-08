import 'package:flutter/material.dart';

import '../models/measurement_engine_info.dart';
import '../services/measurement_engine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.engine});

  final MeasurementEngine? engine;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MeasurementEngine _engine = widget.engine ?? MeasurementEngine();

  MeasurementEngineInfo? _info;
  DeviceCapabilities? _caps;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final info = await _engine.getEngineInfo();
      final caps = await _engine.getDeviceCapabilities();
      if (!mounted) return;
      setState(() {
        _info = info;
        _caps = caps;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }

  String get _status {
    if (_error != null) return 'Unavailable';
    if (_info == null) return 'Initializing';
    return 'Ready (measurement not implemented)';
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Adinn Recce Measurement',
                  textAlign: TextAlign.center, style: text.headlineSmall),
              const SizedBox(height: 8),
              Text('Accuracy-First Spatial Measurement POC',
                  textAlign: TextAlign.center, style: text.bodyLarge),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Measurement Engine', style: text.titleMedium),
                      Text('Status: $_status'),
                      if (_info != null) Text('Version: ${_info!.engineVersion}'),
                      if (_caps != null) ...[
                        Text('ARCore: ${_caps!.arCore.wire}'),
                        Text('Depth API: ${_caps!.depth.wire}'),
                      ],
                      if (_error != null)
                        Text(_error!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
