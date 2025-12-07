Accelerometer EventChannel Utility (Assignment)

Overview
This Flutter app reads device accelerometer data from native Android (Kotlin) and iOS (Swift) via an EventChannel and enforces native-side throttling so the Flutter UI only updates 4 times per second (≈250ms). This prevents UI jank while still sampling raw sensor feed at high frequency.

Assignment Requirements Addressed
- Read a high-frequency sensor via EventChannel (Accelerometer).
- Raw data arrives at ≥60 Hz (Android listener uses a fast delay; iOS uses 100 Hz).
- Flutter UI updates limited to 4 Hz (throttled at 250ms on native side).
- Throttling implemented entirely natively (Kotlin/Swift), before sending to Flutter.

Architecture
- Native → EventChannel → Dart Stream → ViewModel → UI widgets.
- Channel name: com.bmoni/accelerometer.
- Payload: { x, y, z, timestamp }.

Native Implementation
Android (Kotlin)
- Registers SensorManager listener for TYPE_ACCELEROMETER with SENSOR_DELAY_FASTEST (maximum device-supported rate), captures SensorEvent values.
- Throttles using lastEmitTime and THROTTLE_INTERVAL_MS = 250; only emits when 250ms have elapsed.
- Emits a map to EventChannel; handles no-sensor error; unregisters on cancel.

iOS (Swift)
- Uses CMMotionManager with accelerometerUpdateInterval = 0.01 (100 Hz).
- startAccelerometerUpdates(on main queue) and throttle with lastEmitTime and throttleInterval = 0.25s.
- Emits dictionary with x, y, z and millisecond timestamp; stops updates on cancel.

Dart Layer
- AccelerometerService subscribes to EventChannel broadcast stream, validates payloads, maps to AccelerometerData.
- AccelViewModel collects the last 150 samples and computes magnitude sqrt(x^2 + y^2 + z^2); exposes running/start/stop/clear.
- UI uses Provider selectors to minimize rebuilds and keep frames smooth at throttled cadence.

UI
- NumberCard: latest x, y, z, magnitude + progress bar.
- RadialGauge: circular progress indicator with needle and last magnitude.
- MultilineChart (fl_chart): lines for x, y, z (straight) and magnitude (curved) over the recent window.
- Floating actions: Start/Stop stream, Clear history; tip to move device.


Running
- flutter pub get
- flutter run (attach a physical device).
