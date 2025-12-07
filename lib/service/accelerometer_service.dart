import 'package:flutter/services.dart';
import 'package:test_1/models/accelerometer_data.dart';

class AccelerometerService {
  static const EventChannel _channel = EventChannel('com.bmoni/accelerometer');

  Stream<AccelerometerData>? _stream;

  Stream<AccelerometerData> get accelerometerStream {
    _stream ??= _channel
        .receiveBroadcastStream()
        .where((event) => event is Map)
        .map<AccelerometerData?>((dynamic event) {
          try {
            final data = AccelerometerData.fromMap(event as Map<dynamic, dynamic>);
            
            if (data.x.isFinite && data.y.isFinite && data.z.isFinite) {
              return data;
            }
            return null;
          } catch (_) {
            
            return null;
          }
        })
        
        .where((e) => e != null)
        .cast<AccelerometerData>();
    return _stream!;
  }
}