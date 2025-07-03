import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiriskapp/weatherstationsdata.dart';
import 'package:multiriskapp/predict.dart';

class Floodscreen extends StatefulWidget {
  final Position position;
  const Floodscreen({super.key, required this.position});

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  final WeatherStationService _weatherService = WeatherStationService();

  Map<String, dynamic>? actualData;
  Map<String, dynamic>? historicalData;
  String? floodRiskLevel;

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

    setState(() {
      floodRiskLevel = predictor.floodRiskLevel;
    });

    print(predictor.floodRiskLevel);
  }

  @override
  Widget build(BuildContext context) {
    Color floodRiskColor;
    String floodRiskText;

    switch(floodRiskLevel) {
      case 'LOW':
        floodRiskText = 'Low';
        floodRiskColor = Colors.green;
        break;
      case 'MEDIUM':
        floodRiskText = 'Medium';
        floodRiskColor = Colors.amber;
        break;
      case 'HIGH':
        floodRiskText = 'High';
        floodRiskColor = Colors.red;
        break;
      default:
        floodRiskText = 'Getting Risk';
        floodRiskColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Flood Risk Screen"),),
      body: isLoading
      ? const Center(child: CircularProgressIndicator(),)
      : error != null
        ? Center(child: Text("Error: $error"))
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(),
              Icon(Icons.water, color: floodRiskColor, size: 65,),
              Text("Flood Risk: $floodRiskText"),
              const SizedBox(height: 0),
              Text("Humidity: ${actualData!['humidity']} %"),
              Text("Rain (Total): ${actualData!['rain']} mm"),
              Text("Rain (Rate): ${actualData!['precipRate']}"),
              Text("SPI: ${historicalData!['spi']}"),
              const Divider(),
            ],
          ),
        )
      ,
    );
  }
}