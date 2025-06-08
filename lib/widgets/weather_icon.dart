// widgets/weather_icon.dart
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;

  const WeatherIcon({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (condition.toLowerCase()) {
      case 'clear':
        icon = Icons.wb_sunny;
        color = Colors.orange;
        break;
      case 'clouds':
        icon = Icons.cloud;
        color = Colors.grey;
        break;
      case 'rain':
        icon = Icons.grain;
        color = Colors.blue;
        break;
      case 'thunderstorm':
        icon = Icons.flash_on;
        color = Colors.purple;
        break;
      case 'snow':
        icon = Icons.ac_unit;
        color = Colors.lightBlue;
        break;
      default:
        icon = Icons.wb_cloudy;
        color = Colors.grey;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Icon(
        icon,
        key: ValueKey<String>(condition),
        size: 100,
        color: color,
      ),
    );
  }
}