import 'package:flutter/material.dart';
import 'package:smartirregation/shared/remote/firebase_helper.dart';
import 'weather_page.dart';
import 'time_based_page.dart';
import 'moisture_level_page.dart';
import 'temperature_level_page.dart';
import 'water_level_page.dart';
import 'fertilizer_page.dart';
import 'rain_sensor_page.dart';
import 'bump_status.dart';
import 'lights_page.dart';
import 'settings_page.dart';
import 'notifications_page.dart';
import 'irriga_schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track active tab

  void _logout(BuildContext context) {
    FirebaseHelper.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/farmer_details');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/schedule');
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NotificationsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'AGRI IRRIGATION',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary color
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const HomeContent(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Farmer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF255929), // Secondary color
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Home Content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/grow-grass.png', // Your image path
            fit: BoxFit.cover,
            height: 150, // Adjust height as needed
          ),
        ),

        // Main Content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              buildFeatureCard(context, 'Time Based', Icons.access_time, const TimeBasedPage()),
              buildFeatureCard(context, 'Moisture Level', Icons.water_damage, const MoistureLevelPage()),
              buildFeatureCard(context, 'Temperature Level', Icons.thermostat, const TemperatureLevelPage()),
              buildFeatureCard(context, 'Water Level', Icons.invert_colors, const WaterLevelPage()),
              buildFeatureCard(context, 'Fertilizer', Icons.agriculture, const FertilizerPage()),
              buildFeatureCard(context, 'Rain Sensor', Icons.water_drop, const RainSensorPage()),
              buildFeatureCard(context, 'Bump Status', Icons.settings, const BumpStatusPage()),
              buildFeatureCard(context, 'Lights', Icons.lightbulb, const LightsPage()),
              buildFeatureCard(context, 'Weather', Icons.cloud, const WeatherPage()),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFeatureCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFFFFFFF), // Card background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF1B401D)), // Primary color
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B401D), // Primary color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
