import 'package:flutter/foundation.dart';
import 'package:multiriskapp/weatherstationsdata.dart';

import 'package:geolocator/geolocator.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

//Flood AI model
class FloodPrediction {
    Interpreter? _interpreter;
    String FloodRiskLevel = "Not inferred";

    Future<void> loadFloodModel() async {
        try {
            _interpreter = await Interpreter.fromAsset('assets\flood_model.tflite');
            print('Model loaded correctly');
        } catch (e) {
            print('error');
        }
    }

    Future<void> predictFlood(Position position) async {
        final weatherService = WeatherStationService();

        //Get actual data
        final actualData = await weatherService.getActualData(position);

        //Get historical data
        final historicalData = await weatherService.getHistoricalData(position);

        //Get the variables needed to calculate risk
        double spi = historicalData['spi'] ?? 0.0 ;
        double precipTotal = actualData['rain'] ?? 0.0 ;
        double precipRate = actualData['precipRate'] ?? 0.0 ;
        double humidity = (actualData['humidity'] ?? 0.0) / 100;

        List<double> FloodInputData = [spi, precipTotal, precipRate, humidity];

        var floodInput = [Float32List.fromList(FloodInputData)];
        var floodOutput = List.filled(3, 0.0).reshape([1, 3]);

        _interpreter?.run(floodInput, floodOutput);

        int floodPredictedClass = floodOutput[0].indexWhere((element) {
            double maxValue = (floodOutput[0] as List<dynamic>).reduce(
                (a, b) => (a as double) > (b as double) ? a : b,
            );
            return element == maxValue;
        });

        switch (floodPredictedClass) {
            case 0:
                FloodRiskLevel = 'LOW';
                break;
            case 1:
                FloodRiskLevel = 'MEDIUM';
                break;
            case 2:
                FloodRiskLevel = 'HIGH';
                break;
        }

        print('Flood RisK: $FloodRiskLevel');
    }
}

//Fire AI model
class FirePrediction {
    Interpreter? _interpreter;
    String FireRiskLevel = "Not inferred";

    Future<void> loadFireModel() async {
        try {
            _interpreter = await Interpreter.fromAsset('assets/flood_model.tflite');
        } catch (e) {
            print('error');
        }
    }

    Future<void> predictFire(Position position) async {
        final weatherService = WeatherStationService();

        //Get actual data
        final actualData = await weatherService.getActualData(position);

        //Variables for risk calculation
        
    }
}