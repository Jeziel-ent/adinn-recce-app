# Architecture

```
Flutter                    (UI, navigation, workflow, state presentation, results display)
        ↓  Platform Channel: MethodChannel "com.adinn.recce/measurement_engine"
Kotlin Measurement Engine  (measurement-engine/ Gradle module; handler in android/app/.../bridge)
        ↓
CameraX + ARCore           (frames; SLAM/VIO tracking, camera pose, world coords, hit-test, anchors, Depth where supported)
        ↓
3D Measurement             (four 3D corner points → distances → width/height/area)
        ↓
Validation                 (rectangle/square checks, quality gates, reject/retry)
```

## Layer responsibilities

**Flutter / Dart (UI and application layer)** – screens, navigation, workflow, state
presentation, user interaction, results display. It receives measurement state and results from
Kotlin. It contains **no measurement mathematics, no ARCore logic and no measurement-path
camera code**. The measurement-critical camera is CameraX in Kotlin, not a Flutter camera plugin.

**Kotlin (measurement-critical native layer)** – camera integration, ARCore integration, spatial
tracking access, depth, 3D points, geometry, validation and all accuracy-critical logic. The
engine has no Flutter dependency; only the thin `MeasurementEngineChannel` in the app module
knows about Flutter. This keeps the engine unit-testable and replayable on its own.

## Principles

- **Not** `Camera → AI → guessed dimensions`. Physical dimensions come only from 3D geometry
  built on ARCore spatial data. AI/CV may help *identify* the target and its corners; it never
  supplies sizes.
- ARCore is the spatial foundation, not the measurement algorithm.
- The background need not be planar. Plane detection may be used opportunistically but is never
  required.
- A physical board may or may not exist; the target is usually a rectangle or square.
- Device capabilities (ARCore, Depth) differ per phone; they are detected at runtime and never assumed.

## Platform channel contract

Channel `com.adinn.recce/measurement_engine`:

| Method | Returns |
|---|---|
| `getEngineInfo` | `{engineVersion: String, measurementImplemented: bool}` |
| `getDeviceCapabilities` | `{arCore: String, depth: String}` (enum names from `DeviceCapabilities`) |

Dart side: `lib/platform/measurement_channel.dart` (raw channel) → `lib/services/measurement_engine.dart`
(typed facade) → `lib/models/measurement_engine_info.dart` (typed models). Unknown or unrecognised
values map to `UNKNOWN`, never to a supported state.

## What exists today

- The two channel methods above, implemented in Kotlin.
- `ArCoreCapabilityDetector` maps `ArCoreApk.checkAvailability` to a typed status. Depth stays
  `UNKNOWN` until it can be verified with an ARCore session.
- ARCore and CameraX are declared as dependencies of `measurement-engine`; nothing uses them yet.
- The manifest marks ARCore as *optional* so the app installs everywhere and reports honestly.
