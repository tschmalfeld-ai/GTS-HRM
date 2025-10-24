import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/heart_rate_data.dart';
import '../services/ble_service.dart';
import '../services/database_helper.dart';

class HeartRateProvider with ChangeNotifier {
  final BleService _bleService = BleService.instance;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  int _currentHeartRate = 0;
  bool _isConnected = false;
  bool _isRecording = false;
  List<HeartRateData> _historicalData = [];
  
  StreamSubscription? _heartRateSubscription;
  StreamSubscription? _connectionSubscription;

  int get currentHeartRate => _currentHeartRate;
  bool get isConnected => _isConnected;
  bool get isRecording => _isRecording;
  List<HeartRateData> get historicalData => _historicalData;

  HeartRateProvider() {
    _initializeStreams();
  }

  void _initializeStreams() {
    _heartRateSubscription = _bleService.heartRateStream.listen((heartRate) {
      _currentHeartRate = heartRate;
      notifyListeners();
      
      if (_isRecording && heartRate > 0) {
        _saveHeartRate(heartRate);
      }
    });

    _connectionSubscription = _bleService.connectionStream.listen((connected) {
      _isConnected = connected;
      if (!connected) {
        _currentHeartRate = 0;
        _isRecording = false;
      }
      notifyListeners();
    });
  }

  Future<void> _saveHeartRate(int heartRate) async {
    try {
      final data = HeartRateData(
        id: 0,
        heartRate: heartRate,
        timestamp: DateTime.now(),
      );
      await _dbHelper.insertHeartRate(data);
    } catch (e) {
      print('Error saving heart rate: $e');
    }
  }

  void startRecording() {
    if (_isConnected && !_isRecording) {
      _isRecording = true;
      notifyListeners();
    }
  }

  void stopRecording() {
    if (_isRecording) {
      _isRecording = false;
      notifyListeners();
    }
  }

  Future<void> loadHistoricalData() async {
    try {
      _historicalData = await _dbHelper.getAllHeartRateData();
      notifyListeners();
    } catch (e) {
      print('Error loading historical data: $e');
    }
  }

  Future<List<HeartRateData>> getDataForDateRange(DateTime start, DateTime end) async {
    try {
      return await _dbHelper.getHeartRateDataByDateRange(start, end);
    } catch (e) {
      print('Error getting date range data: $e');
      return [];
    }
  }

  Future<void> clearAllData() async {
    try {
      await _dbHelper.deleteAllData();
      _historicalData = [];
      notifyListeners();
    } catch (e) {
      print('Error clearing data: $e');
    }
  }

  @override
  void dispose() {
    _heartRateSubscription?.cancel();
    _connectionSubscription?.cancel();
    super.dispose();
  }
}
