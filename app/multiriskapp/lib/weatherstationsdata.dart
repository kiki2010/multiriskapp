import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherStationService {
  static final WeatherStationService _instance = WeatherStationService._internal();
  factory WeatherStationService() => _instance;
  WeatherStationService._internal();

  Map<String, dynamic>? _cache;

  Future<Map<String, dynamic>> fetchWeather(Position position) async {
    if (_cache != null) return _cache!;

    final lat = position.latitude;
    final lon = position.longitude;

    final url = ''; 

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _cache = json.decode(response.body);
      return _cache!;
    } else {
      throw Exception('Error al obtener clima');
    }
  }

  void clearCache() {
    _cache = null;
  }
}
