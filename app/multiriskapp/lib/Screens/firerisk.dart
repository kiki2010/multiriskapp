import 'package:multiriskapp/generated/l10n.dart';
import 'package:multiriskapp/predict.dart';
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
  
  //Maps for saving the data get on the weather API
  Map<String, dynamic>? actualData;
  String? fireRiskLevel;

  bool isLoading = true;
  String? error;

  //Getting the meteorological data and AI prediction, executing the funtions in charge of that
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
    _predictFireRisk();
  }

  //Get weather data
  Future<void> _loadWeatherData() async {
    try {
      await _weatherService.getNearestStation(widget.position);
      final actual = await _weatherService.getActualData(widget.position);

      //Updating the values ​​of the variables with the data obtained
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
  
  //AI prediction
  Future<void> _predictFireRisk() async {
    Position pos = await Geolocator.getCurrentPosition();

    final predictor = FirePrediction();
    await predictor.loadFireModel();
    await predictor.predictFire(pos);
    
    //Save the flood risk
    setState(() {
      fireRiskLevel = predictor.fireRiskLevel;
    });

    print('Fire Risk: $fireRiskLevel');
  }

  @override
  Widget build(BuildContext context) {
    Color fireRiskColor;
    String fireRiskText;

    //Depending on the case, determine a text and color
    switch(fireRiskLevel) {
      case 'LOW':
        fireRiskText = AppLocalizations.of(context).low;
        fireRiskColor = Colors.green;
        break;
      case 'MEDIUM':
        fireRiskText = AppLocalizations.of(context).medium;
        fireRiskColor = Colors.amber;
        break;
      case 'HIGH':
        fireRiskText = AppLocalizations.of(context).high;
        fireRiskColor = Colors.red;
        break;
      default:
        fireRiskText = AppLocalizations.of(context).getRisk;
        fireRiskColor = Colors.grey;
    }

    //Scaffold of the app
    return Scaffold(
      //Title of the screen
      appBar: AppBar(title: Text(AppLocalizations.of(context).titleFireRiskScreen)),
      //Body with a Circular Progress Indicator, until the data is obtained
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Divider, all the data, but the Risk Icon is outside a sizedBox, I think Dividers looks cool
                      const Divider(),
                      Icon(Icons.local_fire_department, color: fireRiskColor, size: 65,),
                      Text(AppLocalizations.of(context).fireRiskLevel(fireRiskText)),
                      const SizedBox(height: 0),
                      Text(AppLocalizations.of(context).temperature(actualData!['temperature'])),
                      Text(AppLocalizations.of(context).humidity(actualData!['humidity'])),
                      Text(AppLocalizations.of(context).wind(actualData!['windSpeed'])),
                      const Divider(),
                    ],
                  ),
                ),
    );
  }
}
