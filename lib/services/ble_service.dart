import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  static final BleService instance = BleService._init();
  BleService._init();

  final StreamController<int> _heartRateController = StreamController<int>.broadcast();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  
  Stream<int> get heartRateStream => _heartRateController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;

  BluetoothDevice? _connectedDevice;
  StreamSubscription? _deviceStateSubscription;
  StreamSubscription? _characteristicSubscription;

  static const String heartRateServiceUuid = '0000180d-0000-1000-8000-00805f9b34fb';
  static const String heartRateMeasurementUuid = '00002a37-0000-1000-8000-00805f9b34fb';

  Future<List<ScanResult>> scanForDevices({Duration timeout = const Duration(seconds: 4)}) async {
    List<ScanResult> results = [];
    StreamSubscription? subscription;
    
    try {
      subscription = FlutterBluePlus.scanResults.listen((scanResults) {
        results = scanResults;
      });
      
      await FlutterBluePlus.startScan(
        timeout: timeout,
        withServices: [Guid(heartRateServiceUuid)],
      );
      
      await Future.delayed(timeout);
    } catch (e) {
      print('Scan error: $e');
    } finally {
      try {
        await FlutterBluePlus.stopScan();
      } catch (e) {
        print('Stop scan error: $e');
      }
      
      await subscription?.cancel();
    }

    return results;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      print('Connecting to device: ${device.platformName}');
      await device.connect(timeout: const Duration(seconds: 15));
      _connectedDevice = device;
      
      _deviceStateSubscription = device.connectionState.listen((state) {
        print('Connection state changed: $state');
        _connectionController.add(state == BluetoothConnectionState.connected);
        if (state == BluetoothConnectionState.disconnected) {
          _cleanup();
        }
      });

      await Future.delayed(const Duration(seconds: 2));
      
      print('Discovering services...');
      List<BluetoothService> services = await device.discoverServices();
      print('Found ${services.length} services');
      
      bool foundHeartRateService = false;
      
      for (var service in services) {
        print('Service UUID: ${service.uuid}');
        if (service.uuid.toString().toLowerCase() == heartRateServiceUuid) {
          foundHeartRateService = true;
          print('Found Heart Rate Service!');
          
          for (var characteristic in service.characteristics) {
            print('Characteristic UUID: ${characteristic.uuid}');
            print('Properties: notify=${characteristic.properties.notify}, indicate=${characteristic.properties.indicate}, read=${characteristic.properties.read}');
            
            if (characteristic.uuid.toString().toLowerCase() == heartRateMeasurementUuid) {
              print('Found Heart Rate Measurement characteristic!');
              
              // Check for BOTH notify and indicate (many HR sensors use indicate)
              if (characteristic.properties.notify || characteristic.properties.indicate) {
                String method = characteristic.properties.notify ? 'notifications' : 'indications';
                print('Setting up $method...');
                await characteristic.setNotifyValue(true);
                
                _characteristicSubscription = characteristic.onValueReceived.listen((value) {
                  if (value.isNotEmpty) {
                    int heartRate = _parseHeartRate(value);
                    print('Heart rate received via $method: $heartRate BPM (raw: $value)');
                    _heartRateController.add(heartRate);
                  }
                }, onError: (error) {
                  print('Stream error: $error');
                });
                
                print('Successfully subscribed to heart rate $method');
              } else {
                print('WARNING: Characteristic does not support notifications or indications!');
              }
            }
          }
        }
      }
      
      if (!foundHeartRateService) {
        print('ERROR: Heart Rate Service not found on this device!');
        print('Available services: ${services.map((s) => s.uuid.toString()).join(', ')}');
      }
      
      _connectionController.add(true);
    } catch (e) {
      print('Connection error: $e');
      _connectionController.add(false);
      rethrow;
    }
  }

  int _parseHeartRate(List<int> value) {
    if (value.isEmpty) return 0;
    
    int flags = value[0];
    bool hrFormat16Bits = (flags & 0x01) != 0;
    
    if (hrFormat16Bits && value.length >= 3) {
      return (value[2] << 8) | value[1];
    } else if (!hrFormat16Bits && value.length >= 2) {
      return value[1];
    }
    
    return 0;
  }

  Future<void> disconnect() async {
    await _connectedDevice?.disconnect();
    _cleanup();
  }

  void _cleanup() {
    _characteristicSubscription?.cancel();
    _deviceStateSubscription?.cancel();
    _connectedDevice = null;
    _connectionController.add(false);
  }

  bool get isConnected => _connectedDevice != null;

  BluetoothDevice? get connectedDevice => _connectedDevice;

  void dispose() {
    _heartRateController.close();
    _connectionController.close();
    _characteristicSubscription?.cancel();
    _deviceStateSubscription?.cancel();
  }
}
