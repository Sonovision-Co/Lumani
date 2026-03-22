# Lumani

Flutter mobile app for patient-guided obstetric ultrasound self-scanning. Patients perform scans at home using a probe (or device camera in development) and securely send results to their obstetrician for review.

## Project Structure

```
app/        # Flutter mobile app (iOS)
```

## Setup

### Prerequisites

- macOS (note: macOS 12 is the minimum currently supported — Flutter is pinned to 3.19.6 via FVM)
- [FVM](https://fvm.app) for Flutter version management
- Xcode 14 (for iOS simulator)
- CocoaPods

### First-time setup

```bash
# Install FVM if you haven't
brew tap leoafarias/fvm && brew install fvm

# Install the pinned Flutter version
cd app
fvm install

# Install dependencies
fvm flutter pub get

# Install iOS dependencies
cd ios && pod install && cd ..
```

### Run the app

```bash
cd app
fvm flutter run
```

Open the iOS Simulator first via Xcode → Open Developer Tool → Simulator.
