import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MoistureLevelPage extends StatefulWidget {
  const MoistureLevelPage({super.key});

  @override
  State<MoistureLevelPage> createState() => _MoistureLevelPageState();
}

class _MoistureLevelPageState extends State<MoistureLevelPage> {
  double moistureLevel = 72; // Mock moisture value

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
          'Moisture Level',
          style: TextStyle(color: Colors.white), // Change title text to white
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary Color
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF2F2F2), // Background Color
            child: Center(
              child: buildGauge(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/soilMoisture.png',
              width: 300, // Adjust size as needed
              height: 200, // Adjust size as needed
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGauge() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SfRadialGauge(
          axes: [
            RadialAxis(
              minimum: 0,
              maximum: 100,
              ranges: [
                GaugeRange(startValue: 0, endValue: 30, color: const Color(0xFF010D03)), // Darkest shade
                GaugeRange(startValue: 30, endValue: 70, color: const Color(0xFF255929)), // Secondary color
                GaugeRange(startValue: 70, endValue: 100, color: const Color(0xFF1B401D)), // Primary color
              ],
              pointers: [NeedlePointer(value: moistureLevel, needleColor: const Color(0xFF0C260E))], // Accent color
              annotations: [
                GaugeAnnotation(
                  widget: Text(
                    '$moistureLevel%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C260E), // Accent color
                    ),
                  ),
                  positionFactor: 0.8,
                  angle: 90,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Moisture Level',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B401D), // Primary color
          ),
        ),
      ],
    );
  }
}
