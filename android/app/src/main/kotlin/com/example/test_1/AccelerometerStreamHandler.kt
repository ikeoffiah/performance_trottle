package com.example.test_1
import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

class AccelerometerStreamHandler(private val context: Context): EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null
    private var sensorManager: SensorManager? = null
    private var accelerometer: Sensor? = null
    private var lastEmitTime = 0L
    private val THROTTLE_INTERVAL_MS = 250L

    private val sensorListener = object : SensorEventListener {
        override fun onSensorChanged(event: SensorEvent?) {
            event?.let {
                val currentTime = System.currentTimeMillis()


                if (currentTime - lastEmitTime >= THROTTLE_INTERVAL_MS) {
                    lastEmitTime = currentTime

                    val data = mapOf(
                        "x" to it.values[0].toDouble(),
                        "y" to it.values[1].toDouble(),
                        "z" to it.values[2].toDouble(),
                        "timestamp" to currentTime
                    )

                    eventSink?.success(data)
                }
            }
        }

        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        accelerometer?.let {
            sensorManager?.registerListener(
                sensorListener,
                it,
                SensorManager.SENSOR_DELAY_FASTEST
            )
        } ?: run {
            events?.error("NO_SENSOR", "Accelerometer not available", null)
        }
    }

    override fun onCancel(arguments: Any?) {
        sensorManager?.unregisterListener(sensorListener)
        eventSink = null
    }

}