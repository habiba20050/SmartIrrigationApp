import 'package:flutter/material.dart';

class RainSensorPage extends StatefulWidget {
  const RainSensorPage({super.key});

  @override
  State<RainSensorPage> createState() => _RainSensorPageState();
}

class _RainSensorPageState extends State<RainSensorPage> {
  bool isRaining = false;
  bool isLoading = false;

  void updateRainStatus() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulating sensor response

    setState(() {
      isRaining = !isRaining;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        title: const Text(
          'Rain Sensor',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary color
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF2F2F2), // Background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                isRaining ? Icons.cloudy_snowing : Icons.wb_sunny,
                key: ValueKey(isRaining),
                size: 100,
                color: isRaining ? const Color(0xFF010D03) : const Color(0xFF255929),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Rain Sensor Monitoring',
              style: TextStyle(
                fontSize: 26,
                color: Color(0xFF1B401D), // Title color changed to white
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),
            Image.asset(
              'assets/images/rain.jpg',
              width: 300,
              height: 260,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),

            const Text(
              'Detect rainfall and adjust irrigation accordingly.',
              style: TextStyle(fontSize: 18, color: Color(0xFF0C260E)), // Accent color
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isRaining ? const Color(0xFF010D03) : const Color(0xFF255929),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isRaining ? 'Status: RAIN DETECTED' : 'Status: NO RAIN',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : updateRainStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: isRaining ? const Color(0xFF010D03) : const Color(0xFF1B401D),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                isRaining ? 'Stop Rain' : 'Simulate Rain',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
