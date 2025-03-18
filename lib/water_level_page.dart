import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterLevelPage extends StatelessWidget {
  const WaterLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    double waterLevel = 70; // Example value, replace with real sensor data

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Water Level',
          style: TextStyle(color: Colors.white), // Change title text to white
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary color
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF2F2F2), // Background color
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Water Level Gauge
                  SizedBox(
                    height: 250,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          startAngle: 180,
                          endAngle: 0,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 15,
                            color: Color(0xFF255929), // Secondary color
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: waterLevel,
                              width: 15,
                              color: const Color(0xFF0C260E), // Accent color
                              cornerStyle: CornerStyle.bothCurve,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                '$waterLevel%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF010D03), // Darkest shade
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Water Level',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B401D), // Primary color
                    ),
                  ),
                  const SizedBox(height: 60), // Add some space before the image
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/water-level.png',
                width: 450, // Adjust size as needed
                height: 400, // Adjust size as needed
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
