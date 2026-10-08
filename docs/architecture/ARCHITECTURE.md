# Architecture

```
React Native UI            (screens, workflow; no measurement maths)
        ↓  native bridge (android/app/.../bridge/MeasurementEngineModule.kt)
Kotlin Native Measurement Engine   (measurement-engine/ Gradle module)
        ↓
CameraX                    (frames, lifecycle)
        ↓
ARCore                     (SLAM/VIO tracking, camera pose, world coords, hit-test, anchors, Depth)
        ↓
3D Spatial Measurement     (four 3D corner points → distances → width/height/area)
        ↓
Validation                 (rectangle/square checks, quality gates, reject/retry)
```

## Principles

- **Not** `Camera → AI → guessed dimensions`. Physical dimensions come only from 3D geometry
  built on ARCore spatial data. AI/CV may help *identify* the target and its corners; it never
  supplies sizes.
- ARCore is the spatial foundation, not the measurement algorithm.
- The background need not be planar. Plane detection may be used opportunistically but is never
  required.
- A physical board may or may not exist; the target is usually a rectangle or square.
- Measurement-critical code lives in Kotlin. React Native handles UI and workflow only.
- The engine has no React Native dependency, so it can be unit-tested and replayed on its own.
- Device capabilities (ARCore, Depth) differ per phone; they are detected at runtime and never assumed.

## What exists today

- `MeasurementEngineModule` exposes `getEngineInfo()` and `getDeviceCapabilities()`.
- `ArCoreCapabilityDetector` maps `ArCoreApk.checkAvailability` to a typed status. Depth stays
  `UNKNOWN` until it can be verified with an ARCore session.
- ARCore and CameraX are declared as dependencies of `measurement-engine`; nothing uses them yet.
- The manifest marks ARCore as *optional* so the app installs everywhere and reports honestly.
