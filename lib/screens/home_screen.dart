import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/heart_rate_provider.dart';
import 'device_scanner_screen.dart';
import 'graph_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate Monitor'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.bluetooth),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeviceScannerScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<HeartRateProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              _buildConnectionStatus(provider),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Current Heart Rate',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildHeartRateDisplay(provider.currentHeartRate),
                      const SizedBox(height: 40),
                      if (provider.isConnected) ...[
                        _buildRecordingButton(context, provider),
                        const SizedBox(height: 20),
                      ],
                      if (!provider.isConnected)
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DeviceScannerScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.bluetooth_searching),
                          label: const Text('Connect Device'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              _buildNavigationButtons(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConnectionStatus(HeartRateProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: provider.isConnected ? Colors.green.shade100 : Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            provider.isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
            color: provider.isConnected ? Colors.green.shade700 : Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            provider.isConnected ? 'Connected' : 'Not Connected',
            style: TextStyle(
              color: provider.isConnected ? Colors.green.shade700 : Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (provider.isRecording) ...[
            const SizedBox(width: 16),
            Icon(Icons.fiber_manual_record, color: Colors.red.shade700, size: 16),
            const SizedBox(width: 4),
            Text(
              'Recording',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeartRateDisplay(int heartRate) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.shade50,
        border: Border.all(
          color: Colors.red.shade700,
          width: 4,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heartRate.toString(),
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          Text(
            'BPM',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingButton(BuildContext context, HeartRateProvider provider) {
    return ElevatedButton.icon(
      onPressed: () {
        if (provider.isRecording) {
          provider.stopRecording();
        } else {
          provider.startRecording();
        }
      },
      icon: Icon(provider.isRecording ? Icons.stop : Icons.fiber_manual_record),
      label: Text(provider.isRecording ? 'Stop Recording' : 'Start Recording'),
      style: ElevatedButton.styleFrom(
        backgroundColor: provider.isRecording ? Colors.grey.shade700 : Colors.red.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GraphScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.show_chart),
              label: const Text('View History'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
