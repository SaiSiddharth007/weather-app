// lib/widgets/weather_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:weather_now/models/weather_model.dart';
import 'package:weather_now/widgets/weather_icon.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel weatherData;

  const WeatherDetailScreen({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(weatherData.cityName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WeatherIcon(condition: weatherData.condition),
            const SizedBox(height: 30),
            Text(
              '${weatherData.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              weatherData.condition,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetailCard('Humidity', '${weatherData.humidity}%'),
                _buildDetailCard('Wind', '${weatherData.windSpeed} km/h'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}