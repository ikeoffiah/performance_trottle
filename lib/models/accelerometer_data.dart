class AccelerometerData {
  final double x;
  final double y;
  final double z;

  AccelerometerData({required this.x, required this.y, required this.z});

  factory AccelerometerData.fromMap(Map<dynamic, dynamic> map) {
    return AccelerometerData(
      x: (map['x'] as num).toDouble(),
      y: (map['y'] as num).toDouble(),
      z: (map['z'] as num).toDouble(),
    );
  }
}