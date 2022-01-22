import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/models.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherApp> {
  final _cityTextEditingController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_response != null)
                Column(
                  children: [
                    Image.network(_response!.iconUrl),
                    Text(
                      '${_response!.tempInfo.temperature} C',
                      style: const TextStyle(fontSize: 40),
                    ),
                    Text(_response!.weatherInfo.description)
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _cityTextEditingController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(labelText: 'City'),
                    )),
              ),
              ElevatedButton(onPressed: _search, child: const Text('Search'))
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response =
        await _dataService.getWeather(_cityTextEditingController.text);
    setState(() => _response = response);
  }
}
