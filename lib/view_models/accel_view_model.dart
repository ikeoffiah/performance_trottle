import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_1/models/accelerometer_data.dart';

import '../service/accelerometer_service.dart';

class AccelViewModel extends ChangeNotifier {
  final AccelerometerService _service = AccelerometerService();

  final int maxLen = 150;
  final List<double> x = [];
  final List<double> y = [];
  final List<double> z = [];
  final List<double> mag = [];

  StreamSubscription? _sub;
  bool running = false;
  

  void start() {
    if (running) return;

    running = true;

    _sub = _service.accelerometerStream.listen(
      (AccelerometerData data) {
        _add(data.x, data.y, data.z);
      },
      onError: (Object error, StackTrace st) {
        Fluttertoast.showToast(
          msg: "Accelerometer error occurred",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        stop();
      },
      cancelOnError: false,
    );

    notifyListeners();
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
    running = false;
    notifyListeners();
  }

  void toggle() => running ? stop() : start();

  void clear() {
    x.clear();
    y.clear();
    z.clear();
    mag.clear();
    notifyListeners();
  }

  void _add(double xv, double yv, double zv) {
    if (!(xv.isFinite && yv.isFinite && zv.isFinite)) {
      return;
    }

    if (x.length >= maxLen) {
      x.removeAt(0);
      y.removeAt(0);
      z.removeAt(0);
      mag.removeAt(0);
    }

    x.add(xv);
    y.add(yv);
    z.add(zv);
    mag.add(sqrt(xv * xv + yv * yv + zv * zv));

    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _sub = null;
    super.dispose();
  }
}