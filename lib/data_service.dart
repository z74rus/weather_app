import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/models.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final Map<String, String> queryParameters = {
      'q': city,
      // Your Api Key from openweather.org
      'appid': 'API_KEY',
      'units': 'metric'
    };

    final uri = Uri.https("api.openweathermap.org", "/data/2.5/weather", queryParameters);

    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    return WeatherResponse.fromJson(json);
  }
}