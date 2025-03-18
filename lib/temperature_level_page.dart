import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureLevelPage extends StatelessWidget {
  final double temperatureValue;

  const TemperatureLevelPage({super.key, this.temperatureValue = 28});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Temperature Level',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B401D),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // Background color
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temperature Display
            Text(
              '$temperatureValue°C',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B401D),
              ),
            ),
            const SizedBox(height: 10),

            // Temperature Gauge
            SizedBox(
              height: 280,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: -10,
                    maximum: 50,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: -10,
                        endValue: 10,
                        color: const Color(0xFF010D03), // Cold
                      ),
                      GaugeRange(
                        startValue: 10,
                        endValue: 30,
                        color: const Color(0xFF255929), // Normal
                      ),
                      GaugeRange(
                        startValue: 30,
                        endValue: 50,
                        color: const Color(0xFF0C260E), // Hot
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: temperatureValue,
                        needleColor: const Color(0xFF1B401D),
                        knobStyle: const KnobStyle(
                          color: Color(0xFF0C260E),
                          borderColor: Colors.white,
                          borderWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Status Indicator
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: _getStatusColor(temperatureValue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _getTemperatureStatus(temperatureValue),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTemperatureStatus(double value) {
    if (value < 10) return 'Cold ❄️';
    if (value < 30) return 'Normal ✅';
    return 'Hot 🔥';
  }

  Color _getStatusColor(double value) {
    if (value < 10) return const Color(0xFF010D03); // Cold
    if (value < 30) return const Color(0xFF255929); // Normal
    return const Color(0xFF0C260E); // Hot
  }
}
