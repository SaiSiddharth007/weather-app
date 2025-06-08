import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_now/services/weather_service.dart';
import 'package:weather_now/widgets/city_card.dart';
import 'package:weather_now/widgets/weather_detail_screen.dart';
import 'package:weather_now/widgets/weather_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  String? _selectedCity;
  bool _isLoading = false;
  String _errorMessage = '';

  final List<String> _cities = [
    'Delhi',
    'Mumbai',
    'Bengaluru',
    'Kolkata',
    'Chennai',
    'Hyderabad'
  ];

  void _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weatherData = await _weatherService.getWeather(city);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(weatherData: weatherData),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch weather: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      final weatherData = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(weatherData: weatherData),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Location error: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherNow'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _fetchWeather(_cityController.text),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              hint: const Text('Select a city'),
              items: _cities.map((String city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedCity = value);
                if (value != null) _fetchWeather(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Major Cities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _cities.map((city) {
                return CityCard(
                  city: city,
                  onTap: () => _fetchWeather(city),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Use Current Location'),
              onPressed: _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}