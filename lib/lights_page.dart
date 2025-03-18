import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightsPage extends StatefulWidget {
  const LightsPage({super.key});

  @override
  State<LightsPage> createState() => _LightsPageState();
}

class _LightsPageState extends State<LightsPage> {
  bool isLightOn = false; // Initial state

  void toggleLight() async {
    setState(() {
      isLightOn = !isLightOn;
    });

    // Haptic Feedback (Vibration)
    HapticFeedback.lightImpact();

    // IoT Integration (Replace with actual API/MQTT call)
    final String status = isLightOn ? 'ON' : 'OFF';
    await sendLightStatusToServer(status);
  }

  Future<void> sendLightStatusToServer(String status) async {
    // Placeholder for future IoT API or MQTT integration
    print('Light status sent to server: $status');
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
        title: const Text('Lights Control', style: TextStyle(color: Colors.white)), // Title in White
        backgroundColor: const Color(0xFF1B401D), // Primary Color
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // Background Color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Light Icon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Icon(
                  isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  key: ValueKey<bool>(isLightOn),
                  size: 80,
                  color: isLightOn ? Colors.yellow : const Color(0xFF0C260E), // Accent Color
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Lights Control',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF255929), // Secondary Color
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'Turn lights ON or OFF.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Light Status
              Text(
                isLightOn ? 'Status: ON' : 'Status: OFF',
                style: TextStyle(
                  fontSize: 22,
                  color: isLightOn ? const Color(0xFF1B401D) : const Color(0xFF010D03), // Primary or Darkest Shade
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Toggle Button
              ElevatedButton(
                onPressed: toggleLight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLightOn ? const Color(0xFF010D03) : const Color(0xFF255929), // Darkest or Secondary Color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  isLightOn ? 'Turn OFF' : 'Turn ON',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
