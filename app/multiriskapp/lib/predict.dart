import 'package:flutter/foundation.dart';
import 'package:multiriskapp/weatherstationsdata.dart';

import 'package:geolocator/geolocator.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

//Flood AI model
class FloodPrediction {
    Interpreter? _interpreter;
    String floodRiskLevel = "Not inferred";

    Future<void> loadFloodModel() async {
        try {
            _interpreter = await Interpreter.fromAsset('assets/flood_model.tflite');
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

        List<double> floodInputData = [spi, precipTotal, precipRate, humidity];

        var floodInput = [Float32List.fromList(floodInputData)];
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
                floodRiskLevel = 'LOW';
                break;
            case 1:
                floodRiskLevel = 'MEDIUM';
                break;
            case 2:
                floodRiskLevel = 'HIGH';
                break;
        }

        print('Flood RisK: $floodRiskLevel');
    }
}

//Fire AI model
class FirePrediction {
    Interpreter? _interpreter;
    String fireRiskLevel = "Not inferred";

    Future<void> loadFireModel() async {
        try {
            _interpreter = await Interpreter.fromAsset('assets/fire_model.tflite');
        } catch (e) {
            print('error');
        }
    }

    Future<void> predictFire(Position position) async {
        final weatherService = WeatherStationService();

        //Get actual data
        final actualData = await weatherService.getActualData(position);

        //Variables for risk calculation
        double temperature = actualData['temperature'] ?? 0.0;
        double humidity = (actualData['humidity'] ?? 0.0) / 100;
        double wind = actualData['windSpeed'] ?? 0.0;

        List<double> fireInputData = [temperature, humidity, wind];

        var fireInput = [Float32List.fromList(fireInputData)];
        var fireOutput = List.filled(3, 0.0).reshape([1, 3]);

        _interpreter?.run(fireInput, fireOutput);
        print('Input: $fireInput');
        print('Output: $fireOutput');

        int firePredictedClass = fireOutput[0].indexWhere((element) {
            double maxValue = (fireOutput[0] as List<dynamic>).reduce(
                (a, b) => (a as double) > (b as double) ? a : b,
            );
            return element == maxValue;
        });

        switch (firePredictedClass) {
            case 0:
                fireRiskLevel = 'LOW';
                break;
            case 1:
                fireRiskLevel = 'MEDIUM';
                break;
            case 2:
                fireRiskLevel = 'HIGH';
                break;
        }

        print('Fire Risk: $fireRiskLevel');
    }
}