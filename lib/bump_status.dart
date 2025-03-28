import 'package:flutter/material.dart';
import 'package:smartirregation/shared/remote/firebase_helper.dart';

class BumpStatusPage extends StatefulWidget {
  const BumpStatusPage({super.key});

  @override
  State<BumpStatusPage> createState() => _BumpStatusPageState();
}

class _BumpStatusPageState extends State<BumpStatusPage> {
  bool isBumpOn = false; // Initial state
  String bumpPath = "Systems/SmartIrrigation/relay/1";

  void toggleBump() {
    setState(() {
      isBumpOn = !isBumpOn;
      FirebaseHelper.updateRealtimeData(
          path: bumpPath, data: {"value": isBumpOn});
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseHelper.getRealtimeData(path: bumpPath).then(
      (value) {
        if (value != null && value.exists)
          isBumpOn = bool.parse(value.child("value").value.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
        title: const Text(
          'Bump Status',
          style:
              TextStyle(color: Colors.white), // ✅ Changed title color to white
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary Color
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings,
                  size: 80, color: Color(0xFF255929)), // Secondary Color
              const SizedBox(height: 20),
              const Text(
                'Bump Condition Check',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF1B401D), // Primary Color
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Check bump status and control.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Status Indicator
              Text(
                isBumpOn ? 'Status: ON' : 'Status: OFF',
                style: TextStyle(
                  fontSize: 22,
                  color: isBumpOn
                      ? const Color(0xFF0C260E)
                      : const Color(0xFF010D03),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Toggle Button
              ElevatedButton(
                onPressed: toggleBump,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isBumpOn
                      ? const Color(0xFF010D03)
                      : const Color(0xFF255929),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  isBumpOn ? 'Turn OFF' : 'Turn ON',
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
