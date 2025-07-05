import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';

const apiKey = "026cda1f35b54cddacda1f35b53cdda3"; //weatherunderground Apikey

class WeatherStationService {
  static final WeatherStationService _instance = WeatherStationService._internal();
  factory WeatherStationService() => _instance;
  WeatherStationService._internal();

  String? _selectedStationId;

  //A variable for each meteorological data
  Map<String, dynamic>? _stationCache;
  Map<String, dynamic>? _actualCache;
  Map<String, dynamic>? _historicalCache;
  Map<String, dynamic>? _forecastCache;

  //Gettting near stations
  Future<Map<String, dynamic>> getNearestStation(Position position) async {
    if (_stationCache != null) return _stationCache!;

    //Variables for latitude and longitude
    final lat = position.latitude;
    final lon = position.longitude;
    
    //URL for getting near weather stations
    final url = 'https://api.weather.com/v3/location/near?geocode=$lat,$lon&product=pws&format=json&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    //When we get the data, look for the data we need
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final stationsIds = data['location']['stationId'];
      final updateTimes = data['location']['updateTimeUtc'];
      final distances = data['location']['distanceKm'];

      final List<Map<String, dynamic>> stations = [];
      
      //We check the weather stations and choose the correct ones.
      for (int i = 0; i < stationsIds.length; i++) {
        if (updateTimes[i] != null) {
          stations.add({
            'stationId': stationsIds[i],
            'updateTime': updateTimes[i],
            'distance': distances[i],
          });
        }
      }

      //We order the stations putting the closest ones first
      stations.sort((a, b) {
        int updateComparison = b['updateTime'].compareTo(a['updateTime']);
        if (updateComparison != 0) return updateComparison;
        return a['distance'].compareTo(b['distance']);
      });
      
      //Save the first (selected) station
      if (stations.isNotEmpty) {
        _selectedStationId = stations.first['stationId'];
      } else {
        throw Exception("No valid stations found");
      }

      _stationCache = data;
      return _stationCache!;
    } else {
      throw Exception('Error getting nearest stations');
    }
  }

  //Getting the actual data, really similar to how we get the station but more simple
  Future<Map<String, dynamic>> getActualData(Position position) async {
    if (_actualCache != null) return _actualCache!;
    if (_selectedStationId == null) await getNearestStation(position);
    

    //We're going to need the selected station ID
    final stationId = _selectedStationId;

    //Create the URL using the station ID
    final url = 'https://api.weather.com/v2/pws/observations/current?stationId=$stationId&format=json&units=m&apiKey=$apiKey';
    
    final response = await http.get(Uri.parse(url));

    //When we get the data, save the things we need.
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final observation = data['observations'][0];

      final int humidity = observation['humidity'];
      final double temp = observation['metric']['temp']?.toDouble() ?? 0.0;
      final double windSpeed = observation['metric']['windSpeed']?.toDouble() ?? 0.0;
      final double precipTotal = observation['metric']['precipTotal']?.toDouble() ?? 0.0;
      final double precipRate = observation['metric']['precipRate']?.toDouble() ?? 0.0;
      
      //Save the values get
      return {
      'temperature': temp,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'rain': precipTotal,
      'precipRate': precipRate,
      };

    } else {
      throw Exception('Error getting actual weather data');
    }
  }

  //Getting the historical data, and the SPI
  Future<Map<String, dynamic>> getHistoricalData(Position position) async {
    if (_historicalCache != null) return _historicalCache!;
    if (_selectedStationId == null) await getNearestStation(position);

    //We alredy know this part, using the station ID to get the data
    final stationId = _selectedStationId;
    final url =
        'https://api.weather.com/v2/pws/dailysummary/7day?stationId=$stationId&format=json&units=m&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    //Some changes, when we get the dara
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final summaries = data['summaries'];

      //Validate the data on summaries
      if (summaries == null || summaries is! List) {
        throw Exception("Invalid or empty summary data");
      }

      double totalPrecipitation = 0;
      List<double> precipitationValues = [];

      Map<DateTime, List<dynamic>> groupedByDay = {};

      //More because of the API estructure, we get the dates, and save everithing with their day
      for (var entry in summaries) {
        if (entry['obsTimeLocal'] != null) {
          String dateStr = entry['obsTimeLocal'].split(' ')[0];
          DateTime date = DateFormat('yyyy-MM-dd').parse(dateStr);
          groupedByDay.putIfAbsent(date, () => []).add(entry);
        }
      }
      
      //For each day we get the precipitations and we add it to the total
      groupedByDay.forEach((date, entries) {
        List<double> dailyValues = entries
            .where((e) => e['metric']?['precipTotal'] != null)
            .map((e) => (e['metric']['precipTotal'] as num).toDouble())
            .toList();

        double dailyPrecip = dailyValues.isNotEmpty
            ? dailyValues.reduce((a, b) => a + b)
            : 0.0;

        totalPrecipitation += dailyPrecip;
        precipitationValues.add(dailyPrecip);
      });

      //Average daily rainfall
      int n = precipitationValues.length;
      double avg = n > 0 ? totalPrecipitation / n : 0.0;

      double variance = 0.0;
      for (var value in precipitationValues) {
        variance += pow(value - avg, 2);
      }
      variance = n > 0 ? variance / n : 0.0;
      double stdDev = sqrt(variance);

      double spi = stdDev > 0 ? (totalPrecipitation - avg * n) / (stdDev * sqrt(n)) : 0.0;

      //Save the data
      _historicalCache = {
        'dailyPrecipitations': precipitationValues,
        'totalPrecipitation': totalPrecipitation,
        'average': avg,
        'standardDeviation': stdDev,
        'spi': spi,
      };

      return _historicalCache!;
    } else {
      throw Exception('Error getting historical data');
    }
  }
  
  //getting the forecast
  Future<Map<String, dynamic>> getForecastData(Position position) async {
    if (_forecastCache != null) return _forecastCache!;

    //This time using the latitude and lenght
    final lat = position.latitude;
    final lon = position.longitude;
    final url =
        'https://api.weather.com/v3/wx/forecast/daily/5day?geocode=$lat,$lon&format=json&units=m&language=en-US&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final forecastApi = json.decode(response.body);

      // getting data from API
      final precipChances = forecastApi['daypart'][0]['precipChance'];
      final precipTypes = forecastApi['daypart'][0]['precipType'];
      final daysOfWeek = forecastApi['dayOfWeek'];
      final forecast = forecastApi['daypart'][0]['wxPhraseLong'];

      // Create a list for the next three days
      List<Map<String, dynamic>> threeDayForecast = [];

      for (int i = 0; i < 3; i++) {
        final dailyForecast = {
          'dayOfWeek': daysOfWeek[i],
          'precipChance': precipChances[i * 2] ?? 0,
          'precipType': precipTypes[i * 2] ?? 'N/A',
          'forecast': forecast[i * 2] ?? 'No data',
        };
        threeDayForecast.add(dailyForecast);
      }
      
      //save data
      _forecastCache = {
        'rawData': forecastApi,
        'threeDaySummary': threeDayForecast,
      };

      return _forecastCache!;
    } else {
      throw Exception('Error getting forecast');
    }
  }
}
