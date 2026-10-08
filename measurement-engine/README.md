# measurement-engine

Standalone Kotlin Android library. No Flutter (or any UI) dependency. Source is under
`src/main/kotlin/com/adinn/recce/measurement/` with one package per responsibility.

| Package | Future responsibility | Today |
|---|---|---|
| `arcore` | ARCore session, SLAM/VIO tracking state, camera pose, world coordinates, raycast/hit-test, anchors, Depth API. Plane detection optional, never required. | capability detection only |
| `depth` | ARCore Depth API access: availability per device, depth confidence, depth sampling at 2D points. | not started (capability reported as UNKNOWN) |
| `camera` | CameraX pipeline: preview/analysis frames, permissions, lifecycle, frame ↔ ARCore sync. | empty |
| `geometry` | 3D coordinate geometry: point-to-point distance, rectangle width/height/area from four 3D corners. Pure, deterministic, unit-tested. | empty |
| `validation` | Rectangle/square validation (opposite sides, right angles, diagonals), tracking-quality and depth-confidence gates, repeatability across captures, reject/retry decisions. | empty |
| `types` | Shared data types (`Point3D`, `DeviceCapabilities`, later result/quality types). | present |

Responsibilities that sit alongside these:

- **Depth** – ARCore Depth API where supported; per-device availability and confidence are reported, never assumed.
- **Computer vision** – OpenCV (later) assists with locating the target and its corners in the image. It outputs 2D candidates that are lifted to 3D via ARCore; it never outputs physical sizes.
- **AI/ML** – may later propose targets/corners. Must not estimate dimensions.

Rules: geometry and validation stay free of Android types so they run as plain JVM tests;
every result carries quality information; poor measurements are rejected, not rounded off.

Run tests: `cd android && ./gradlew :measurement-engine:testDebugUnitTest`.
