import { useEffect, useState } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { MeasurementEngine } from '../native/MeasurementEngine';
import type { DeviceCapabilities, EngineInfo } from '../types/measurementEngine';

export default function HomeScreen() {
  const [info, setInfo] = useState<EngineInfo | null>(null);
  const [caps, setCaps] = useState<DeviceCapabilities | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!MeasurementEngine) {
      setError('Native measurement engine not linked');
      return;
    }
    MeasurementEngine.getEngineInfo().then(setInfo).catch(e => setError(String(e)));
    MeasurementEngine.getDeviceCapabilities()
      .then(setCaps)
      .catch(e => setError(String(e)));
  }, []);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Adinn Recce Measurement</Text>
      <Text style={styles.subtitle}>Accuracy-First Spatial Measurement POC</Text>

      <View style={styles.card}>
        <Text style={styles.label}>Native engine</Text>
        <Text style={styles.value}>
          {info ? `${info.engineVersion} (measurement not implemented)` : '…'}
        </Text>
        <Text style={styles.label}>ARCore</Text>
        <Text style={styles.value}>{caps ? caps.arCore : '…'}</Text>
        <Text style={styles.label}>Depth API</Text>
        <Text style={styles.value}>{caps ? caps.depth : '…'}</Text>
        {error && <Text style={styles.error}>{error}</Text>}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 24,
    backgroundColor: '#ffffff',
  },
  title: { fontSize: 26, fontWeight: '700', color: '#111827', textAlign: 'center' },
  subtitle: { fontSize: 16, color: '#4b5563', marginTop: 8, textAlign: 'center' },
  card: {
    marginTop: 32,
    alignSelf: 'stretch',
    padding: 16,
    borderRadius: 8,
    backgroundColor: '#f3f4f6',
  },
  label: { fontSize: 12, color: '#6b7280', marginTop: 8 },
  value: { fontSize: 15, color: '#111827' },
  error: { marginTop: 12, color: '#b91c1c' },
});
