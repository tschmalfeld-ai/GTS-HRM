class HeartRateData {
  final int id;
  final int heartRate;
  final DateTime timestamp;

  HeartRateData({
    required this.id,
    required this.heartRate,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heart_rate': heartRate,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory HeartRateData.fromMap(Map<String, dynamic> map) {
    return HeartRateData(
      id: map['id'] as int,
      heartRate: map['heart_rate'] as int,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }
}
