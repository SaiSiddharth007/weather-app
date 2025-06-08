import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String _apiKey = 'a5dcc3567fa83c13e60ffd2e96fb6d40';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather. Status: ${response.statusCode}');
    }
  }

  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather. Status: ${response.statusCode}');
    }
  }
}