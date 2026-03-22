# Lumani — Claude Code Guide

## What this project is

Flutter mobile app for obstetric ultrasound self-scanning. Pregnant patients perform guided scans at home using a specialized probe or device camera, then securely send scan data to their obstetrician for review.

## Tech stack

- **Flutter 3.19.6** (pinned via FVM — required for macOS 12 compatibility)
- **Dart 3.3**
- **iOS only** (no Android or web configured yet)
- **Provider** for state management
- **camera** package for live video feed
- **CocoaPods** for iOS native dependencies

## Running the app

```bash
cd app
fvm flutter run
```

Requires the iOS Simulator to be open first.

## Project structure

```
app/
├── lib/
│   ├── main.dart               # Entry point, Provider setup
│   ├── app_theme.dart          # Global theme
│   ├── core/
│   │   └── sources/
│   │       ├── video_source.dart     # Abstract ChangeNotifier base
│   │       ├── camera_source.dart    # Device camera implementation
│   │       └── probe_source.dart     # Probe hardware stub (TODO)
│   └── features/
│       ├── activation/         # Account activation via code
│       ├── welcome/            # Splash screen (2.5s auto-advance)
│       ├── dashboard/          # Main hub: scan status + history
│       ├── scan/               # Live scan interface with animations
│       └── history/            # Scan detail / DICOM viewer placeholder
├── ios/                        # iOS native project
└── test/
```

## Current state

**UI/navigation is complete.** All screens are built and connected. All data is hardcoded (patient: "Jane Doe", doctor: "Dr. Smith").

**Not yet implemented:**
- Backend API (no network calls exist)
- Authentication / activation code validation
- Scan data upload
- DICOM viewer
- Probe hardware SDK (`probe_source.dart` is a stub)
- Image processing pipeline (noted in `camera_source.dart` TODOs)
- Error handling
- Tests

## Environment notes

- Flutter is managed via FVM. Always use `fvm flutter` instead of `flutter` directly, or configure your shell to point to `/Users/Melanie/fvm/default/bin`.
- CocoaPods requires Ruby 4.x (install via Homebrew). If SSL errors occur during `pod install`, set: `export SSL_CERT_FILE=/opt/homebrew/etc/ca-certificates/cert.pem`
- The `camera` package will not function on simulator — the scan screen handles this gracefully with a fallback UI.
