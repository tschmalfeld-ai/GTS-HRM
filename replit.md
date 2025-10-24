# Heart Rate Monitor - Flutter App

## Overview
A Flutter mobile application that connects to Bluetooth Low Energy (BLE) heart rate sensors, displays real-time heart rate data on a dashboard, and visualizes historical recordings in graph format.

## Project Purpose
This app enables users to:
- Connect to BLE heart rate monitors
- View live heart rate readings on an attractive dashboard
- Record heart rate data with timestamps
- Visualize historical heart rate trends in interactive graphs
- Track heart rate statistics (average, min, max)

## Current State
The app is fully implemented with:
- BLE connectivity using flutter_blue_plus
- Real-time heart rate display
- SQLite database for data persistence
- Graph visualization using fl_chart
- Complete permission setup for Android and iOS

## Recent Changes
- October 24, 2025: Initial project creation and GitHub Actions setup
  - Set up Flutter project structure
  - Implemented BLE service for heart rate sensor connectivity
  - Created database helper for storing heart rate data
  - Built three main screens: Dashboard, Scanner, and Graph
  - Configured Android and iOS permissions for BLE
  - Added state management with Provider
  - Fixed vector_math dependency issue for successful compilation
  - Set up GitHub Actions for automated APK builds

## Project Architecture

### Directory Structure
```
lib/
├── models/
│   └── heart_rate_data.dart          # Data model for heart rate readings
├── services/
│   ├── ble_service.dart               # Bluetooth connectivity service
│   └── database_helper.dart           # SQLite database operations
├── providers/
│   └── heart_rate_provider.dart       # State management
├── screens/
│   ├── home_screen.dart               # Main dashboard with live heart rate
│   ├── device_scanner_screen.dart     # BLE device scanning and connection
│   └── graph_screen.dart              # Historical data visualization
└── main.dart                          # App entry point
```

### Key Features
1. **BLE Heart Rate Service**: Scans for and connects to BLE heart rate monitors using the standard Heart Rate Service UUID (0x180D)
2. **Real-time Display**: Shows current heart rate in a clean, circular display with BPM indicator
3. **Data Recording**: Automatically saves heart rate readings to SQLite database when recording is active
4. **Graph Visualization**: Interactive line chart showing heart rate trends over time with statistics
5. **Session Management**: Start/stop recording controls with connection status indicators

### Dependencies
- flutter_blue_plus: BLE connectivity
- fl_chart: Graph visualization
- sqflite: Local database storage
- path_provider: File system access
- provider: State management
- permission_handler: Runtime permissions
- intl: Date/time formatting

### Platform Requirements
- Android: Requires Bluetooth and location permissions
- iOS: Requires Bluetooth usage descriptions
- Physical device needed for BLE testing (emulators don't support BLE)

## Development Notes
- The app uses the standard Bluetooth Heart Rate Service (UUID: 0x180D)
- Heart rate data is stored locally in SQLite for privacy
- The app requires physical devices for testing as BLE is not available in emulators
- Permissions must be granted at runtime for Bluetooth scanning and connection

## Building APKs
- **GitHub Actions**: Automated builds configured - push to GitHub and download APK from Actions artifacts
- **Local Build**: Run `flutter build apk --release` on your machine with Flutter installed
- See `BUILD_INSTRUCTIONS.md` for detailed step-by-step guide
- APK can be installed directly on Android devices for testing with real BLE heart rate sensors
