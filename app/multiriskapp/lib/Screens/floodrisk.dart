import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiriskapp/weatherstationsdata.dart';
import 'package:multiriskapp/predict.dart';

class Floodscreen extends StatefulWidget {
  final Position position;
  Floodscreen({Key? key, required this.position}) : super(key: key);

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  final WeatherStationService _weatherService = WeatherStationService();

  Map<String, dynamic>? actualData;
  Map<String, dynamic>? historicalData;
  String? FloodRiskLevel;

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
    _predictFloodRisk();
  }

  Future<void> _loadWeatherData() async {
    try {
      await _weatherService.getNearestStation(widget.position);
      final actual = await _weatherService.getActualData(widget.position);
      final historical = await _weatherService.getHistoricalData(widget.position);

      setState(() {
        actualData = actual;
        historicalData = historical;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _predictFloodRisk() async {
    Position pos = await Geolocator.getCurrentPosition();

    final predictor = FloodPrediction();
    await predictor.loadFloodModel();
    await predictor.predictFlood(pos);

    FloodRiskLevel = predictor.FloodRiskLevel;

    print(predictor.FloodRiskLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flood Risk Screen"),),
      body: isLoading
      ? const Center(child: CircularProgressIndicator(),)
      : error != null
        ? Center(child: Text("Error: $error"))
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lat: ${widget.position.latitude}, Lng: ${widget.position.longitude}"),
              const SizedBox(height: 20,),
              Text("Humidity: ${actualData!['humidity']} %"),
              Text("Rain (Total): ${actualData!['rain']} mm"),
              Text("Rain (Rate): ${actualData!['precipRate']}"),
              const Divider(),
              Text("Daily Precipitations: ${historicalData!['dailyPrecipitations']}"),
              Text("Total Precipitations: ${historicalData!['totalPrecipitation']} mm"),
              Text("Average Precipitations: ${historicalData!['average']} mm"),
              Text("Standar Deviation: ${historicalData!['standardDeviation']}"),
              Text("SPI: ${historicalData!['spi']}"),
              const Divider(),
              Text("Risk Level: $FloodRiskLevel"),
            ],
          ),
        )
      ,
    );
  }
}