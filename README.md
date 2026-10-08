# Adinn Recce Measurement App

Accuracy-first Android spatial measurement project for Adinn Advertising Services Ltd.

Goal: measure rectangular / square signage areas with a smartphone camera, even when the
surroundings are irregular (sky, trees, road, buildings). Eventually the system determines four
3D corner points and derives width, height and area.

**Status: foundation only.** No measurement is implemented. The app shows a placeholder screen
and reports device capabilities (ARCore availability) from the Kotlin engine over a platform channel.

## Stack

| Layer | Technology |
|---|---|
| UI / workflow | Flutter + Dart |
| Bridge | Flutter `MethodChannel` `com.adinn.recce/measurement_engine` |
| Measurement engine | Kotlin (Android library module `measurement-engine/`) |
| Camera | CameraX (dependency declared, not yet used) |
| Spatial tracking | ARCore (availability detection only so far) |
| Computer vision | OpenCV (later, supporting role) |

Flutter is the UI/application layer. Kotlin is the measurement-critical native layer: no
measurement maths and no ARCore/camera logic in Dart.

## Layout

```
lib/                       Flutter app: main.dart, screens/, services/, models/, platform/
android/                   Flutter Android host (+ channel handler in app/.../bridge)
measurement-engine/        Kotlin library: arcore, camera, geometry, validation, types
tests/unit                 Dart unit/widget tests (run with `flutter test tests/unit`)
tests/accuracy             Accuracy experiment protocol (no results yet)
docs/                      architecture, measurement principles, experiments
```

## Commands

```bash
flutter pub get
flutter analyze
flutter test tests/unit
flutter run                                   # on a connected device/emulator
flutter build apk --debug
cd android && ./gradlew :measurement-engine:testDebugUnitTest   # Kotlin unit tests
```

Requires Flutter (stable, developed on 3.47.6), JDK 17–21 and the Android SDK.

## Read first

- [docs/architecture/ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md)
- [docs/measurement/MEASUREMENT_PRINCIPLES.md](docs/measurement/MEASUREMENT_PRINCIPLES.md)
- [tests/accuracy/README.md](tests/accuracy/README.md)

## Windows note

If Gradle fails to download (`Connection timed out` while curl works), set
`JAVA_TOOL_OPTIONS=-Djava.net.preferIPv4Stack=true` before building.
