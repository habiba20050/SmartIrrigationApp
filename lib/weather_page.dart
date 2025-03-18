import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String temperature = 'Loading...';
  String humidity = 'Loading...';
  String forecast = 'Loading...';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Coimbatore&appid=07b41de7463fe54f44366e5f44f2a932&units=metric'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temperature = '${data['main']['temp']}°C';
          humidity = '${data['main']['humidity']}%';
          forecast = data['weather'][0]['description'].toUpperCase();
          isLoading = false;
        });
      } else {
        setState(() {
          temperature = 'Error';
          humidity = 'Error';
          forecast = 'Failed to fetch data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        temperature = 'Error';
        humidity = 'Error';
        forecast = 'No Internet';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to HomePage
          },
        ),
        title: const Text('Weather Information'),
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
              // Weather Icon
              const Icon(Icons.wb_sunny, size: 100, color: Color(0xFF255929)), // Secondary color
              const SizedBox(height: 20),

              // Weather Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFF255929), width: 2), // Secondary color
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Current Weather',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B401D), // Primary color
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '🌡 Temperature: $temperature',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0C260E), // Accent color
                        ),
                      ),
                      Text(
                        '💧 Humidity: $humidity',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0C260E), // Accent color
                        ),
                      ),
                      Text(
                        '🌤 Forecast: $forecast',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF0C260E), // Accent color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
