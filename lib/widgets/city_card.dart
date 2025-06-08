// widgets/city_card.dart
import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String city;
  final VoidCallback onTap;

  const CityCard({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            city,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}