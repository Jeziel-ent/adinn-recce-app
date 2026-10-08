# Adinn Recce Measurement App

Accuracy-first Android spatial measurement project for Adinn Advertising Services Ltd.

Goal: measure rectangular / square signage areas with a smartphone camera, even when the
surroundings are irregular (sky, trees, road, buildings). Eventually the system determines four
3D corner points and derives width, height and area.

**Status: foundation only.** No measurement is implemented. The app shows a placeholder screen
and reports device capabilities (ARCore availability) through the Kotlin bridge.

## Stack

| Layer | Technology |
|---|---|
| UI / workflow | React Native 0.87 + TypeScript |
| Measurement engine | Kotlin (Android library module `measurement-engine/`) |
| Camera | CameraX (dependency declared, not yet used) |
| Spatial tracking | ARCore (availability detection only so far) |
| Computer vision | OpenCV (later, supporting role) |

## Layout

```
App.tsx, index.js          RN entry
src/screens, native, types RN UI, typed bridge wrapper, shared TS types
android/                   Android app host (+ bridge in app/.../bridge)
measurement-engine/        Kotlin library: arcore, camera, geometry, validation, types
tests/unit, tests/accuracy JS unit tests; accuracy experiment protocol (no results yet)
docs/                      architecture, measurement principles, experiments
```

## Commands

```bash
npm install
npm run typecheck && npm run lint && npm test
npm start                  # Metro
npm run android            # install + launch on a connected device/emulator
npm run android:build      # assembleDebug
npm run engine:test        # Kotlin unit tests
```

Requires JDK 17–21, Android SDK (platform 37, build-tools 37), Node >= 22.11. Create
`android/local.properties` with `sdk.dir=...` (git-ignored).

## Read first

- [docs/architecture/ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md)
- [docs/measurement/MEASUREMENT_PRINCIPLES.md](docs/measurement/MEASUREMENT_PRINCIPLES.md)
- [tests/accuracy/README.md](tests/accuracy/README.md)

## Windows note

If Gradle fails to download (`Connection timed out` while curl works), set
`JAVA_TOOL_OPTIONS=-Djava.net.preferIPv4Stack=true` before running Gradle. Also, in
`android/local.properties` use forward slashes in `sdk.dir`.
