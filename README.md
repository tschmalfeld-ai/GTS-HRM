# Heart Rate Monitor - Flutter App

A Flutter mobile application that connects to Bluetooth Low Energy (BLE) heart rate sensors, displays real-time heart rate data, and visualizes historical recordings.

## Features

- **BLE Connectivity**: Scan for and connect to BLE heart rate monitors using the standard Heart Rate Service (UUID: 0x180D)
- **Real-time Display**: View current heart rate in an attractive circular display with BPM indicator
- **Data Recording**: Automatically save heart rate readings to a local SQLite database with timestamps
- **Historical Graphs**: Visualize heart rate trends over time with interactive line charts
- **Statistics**: Track average, minimum, and maximum heart rate values
- **Session Management**: Start/stop recording controls with connection status indicators

## Screenshots

The app includes three main screens:
1. **Dashboard**: Shows current heart rate with connection status and recording controls
2. **Scanner**: Scans for nearby BLE heart rate sensors and connects to them
3. **Graph**: Displays historical heart rate data with interactive charts

## Installation & Running

### Prerequisites
- Flutter SDK installed
- Physical Android or iOS device (BLE doesn't work in emulators)
- Heart rate sensor that supports BLE (chest strap, smartwatch, fitness tracker, etc.)

### Running on Mobile Devices

**For Android:**
```bash
flutter run
```

**For iOS:**
```bash
flutter run
```

### Important Notes

- **Web Version Limitation**: While this project includes web support for preview purposes, BLE functionality is **not available in web browsers**. The app must be run on a physical Android or iOS device to connect to heart rate sensors.
- **Emulator Limitation**: BLE hardware is not available in Android or iOS emulators, so you must use a physical device for testing.
- **Permissions**: The app will request Bluetooth and location permissions at runtime on Android, and Bluetooth permissions on iOS.

## Project Structure

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
│   ├── home_screen.dart               # Main dashboard
│   ├── device_scanner_screen.dart     # BLE device scanning
│   └── graph_screen.dart              # Historical data visualization
└── main.dart                          # App entry point
```

## Dependencies

- **flutter_blue_plus**: BLE connectivity and device communication
- **fl_chart**: Beautiful interactive chart visualization
- **sqflite**: Local SQLite database for data persistence
- **provider**: State management across the app
- **permission_handler**: Runtime permission requests
- **intl**: Date and time formatting

## How It Works

1. **Scanning**: The app scans for BLE devices advertising the Heart Rate Service
2. **Connection**: Select a device from the list to establish a BLE connection
3. **Data Reading**: Once connected, the app subscribes to heart rate notifications
4. **Recording**: Start recording to save heart rate data to the local database
5. **Visualization**: View historical data in graph format with statistics

## Supported Heart Rate Sensors

Any BLE heart rate sensor that implements the standard Bluetooth Heart Rate Service (0x180D) will work, including:
- Polar H10, H9, H7
- Garmin heart rate straps
- Wahoo TICKR
- Apple Watch (when using certain fitness apps)
- Most fitness tracker chest straps

## Database

Heart rate data is stored locally in a SQLite database with the following schema:
- `id`: Auto-incrementing primary key
- `heart_rate`: Integer value in BPM
- `timestamp`: Unix timestamp in milliseconds

Data persists across app sessions and can be cleared from the graph screen.

## Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS IPA:**
```bash
flutter build ios --release
```

## Privacy

All heart rate data is stored locally on your device. No data is transmitted to external servers or services.

## License

This project is created for educational and personal use.
