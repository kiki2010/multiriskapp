import 'package:flutter/material.dart';
import 'package:multiriskapp/generated/l10n.dart';
import 'package:multiriskapp/predict.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiriskapp/weatherstationsdata.dart';

class Floodscreen extends StatefulWidget {
  final Position position;
  const Floodscreen({super.key, required this.position});

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  final WeatherStationService _weatherService = WeatherStationService();
  //Maps for saving the data get on the weather API
  Map<String, dynamic>? actualData;
  Map<String, dynamic>? historicalData;
  String? floodRiskLevel;

  bool isLoading = true;
  String? error;

  //getting the meteorological data and AI prediction, executing the funtions in charge of that
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
    _predictFloodRisk();
  }
  
  //Weather data
  Future<void> _loadWeatherData() async {
    try {
      await _weatherService.getNearestStation(widget.position);
      final actual = await _weatherService.getActualData(widget.position);
      final historical = await _weatherService.getHistoricalData(widget.position);

      //Updating the values ​​of the variables with the data obtained
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

  //AI prediction
  Future<void> _predictFloodRisk() async {
    Position pos = await Geolocator.getCurrentPosition();

    final predictor = FloodPrediction();
    await predictor.loadFloodModel();
    await predictor.predictFlood(pos);
    
    //Save the flood risk
    setState(() {
      floodRiskLevel = predictor.floodRiskLevel;
    });

    print(predictor.floodRiskLevel);
  }

  @override
  Widget build(BuildContext context) {
    Color floodRiskColor;
    String floodRiskText;
    
    //Depending on the case, determine a text and color
    switch(floodRiskLevel) {
      case 'LOW':
        floodRiskText = AppLocalizations.of(context).low;
        floodRiskColor = Colors.green;
        break;
      case 'MEDIUM':
        floodRiskText = AppLocalizations.of(context).medium;
        floodRiskColor = Colors.amber;
        break;
      case 'HIGH':
        floodRiskText = AppLocalizations.of(context).high;
        floodRiskColor = Colors.red;
        break;
      default:
        floodRiskText = AppLocalizations.of(context).getRisk;
        floodRiskColor = Colors.grey;
    }
    
    //Scaffold of the app
    return Scaffold(
      //Title of the screen
      appBar: AppBar(title: Text(AppLocalizations.of(context).titleFloodRiskScreen),),
      //Body with a Circular Progress Indicator, until the data is obtained
      body: isLoading
      ? const Center(child: CircularProgressIndicator(),)
      : error != null
        ? Center(child: Text("Error: $error"))
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Divider, all the data, but the Risk Icon is outside a sizedBox, I think Dividers looks cool
              const Divider(),
              Icon(Icons.water, color: floodRiskColor, size: 65,),
              Text(AppLocalizations.of(context).floodRiskLevel(floodRiskText)),
              const SizedBox(height: 0),
              Text(AppLocalizations.of(context).humidity(actualData!['humidity'])),
              Text(AppLocalizations.of(context).totalRain(actualData!['rain'])),
              Text(AppLocalizations.of(context).rateRain(actualData!['precipRate'])),
              Text(AppLocalizations.of(context).SPI(historicalData!['spi'])),
              const Divider(),
            ],
          ),
        )
      ,
    );
  }
}