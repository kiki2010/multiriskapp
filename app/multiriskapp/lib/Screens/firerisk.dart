import 'package:multiriskapp/weatherstationsdata.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class FireScreen extends StatefulWidget {
  final Position position;

  FireScreen({Key? key, required this.position}) : super(key: key);

  @override
  State<FireScreen> createState() => _FireScreenState();
}

class _FireScreenState extends State<FireScreen> {
  final WeatherStationService _weatherService = WeatherStationService();

  Map<String, dynamic>? actualData;

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      await _weatherService.getNearestStation(widget.position);
      final actual = await _weatherService.getActualData(widget.position);

      setState(() {
        actualData = actual;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fire Risk Screen")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lat: ${widget.position.latitude}, Lng: ${widget.position.longitude}"),
                      const SizedBox(height: 20),
                      Text("Temperature: ${actualData!['temperature']} °C"),
                      Text("Humidity: ${actualData!['humidity']} %"),
                      Text("Wind: ${actualData!['windSpeed']} km/h"),
                    ],
                  ),
                ),
    );
  }
}
