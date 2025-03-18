import 'package:flutter/material.dart';
import 'dart:async';

class TimeBasedPage extends StatefulWidget {
  const TimeBasedPage({super.key});

  @override
  _TimeBasedPageState createState() => _TimeBasedPageState();
}

class _TimeBasedPageState extends State<TimeBasedPage> {
  String nextIrrigation = 'Fetching next irrigation time...';

  @override
  void initState() {
    super.initState();
    fetchNextIrrigationTime();
  }

  void fetchNextIrrigationTime() {
    // Simulate fetching next irrigation time
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        nextIrrigation = 'Next irrigation: Today at 6:00 PM';
      });
    });
  }

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
          'Time-Based Irrigation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Title text changed to white
          ),
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary color
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFFF2F2F2), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Time icon
              const Icon(Icons.access_time, size: 80, color: Color(0xFF1B401D)), // Primary color
              const SizedBox(height: 20),

              // Title
              const Text(
                'Time-Based Irrigation Control',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B401D), // Primary color
                ),
              ),
              const SizedBox(height: 10),

              // Image below the title
              Image.asset(
                'assets/images/bumpwater.jpeg',
                width: 300, // Adjust size as needed
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Text(
                'Schedule your irrigation based on time settings.',
                style: TextStyle(fontSize: 16, color: Color(0xFF010D03)), // Darkest shade
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Irrigation Time Display
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: const Color(0xFFF2F2F2), // Background color
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Irrigation Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF255929), // Secondary color
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        nextIrrigation,
                        style: const TextStyle(fontSize: 18, color: Color(0xFF010D03)), // Darkest shade
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Refresh Button
              ElevatedButton.icon(
                onPressed: fetchNextIrrigationTime,
                icon: const Icon(Icons.refresh),
                label: const Text("Update Schedule"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: const Color(0xFF0C260E), // Accent color
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
