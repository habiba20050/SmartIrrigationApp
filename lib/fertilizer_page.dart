import 'package:flutter/material.dart';

class FertilizerPage extends StatelessWidget {
  const FertilizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: const Text(
          'Fertilizer',
          style: TextStyle(color: Colors.white), // ✅ Title remains white
        ),
        backgroundColor: const Color(0xFF1B401D), // ✅ Primary Color
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF2F2F2), // ✅ Background Color
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_filled, size: 80, color: Color(0xFF255929)), // ✅ Secondary Color
              SizedBox(height: 20),
              Text(
                'Fertilizer Scheduling',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B401D), // ✅ Primary Color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
