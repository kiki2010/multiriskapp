import 'dart:math';

class Place {
  final String name;
  final String services;
  final String link;
  final double lat;
  final double lng;
  final double distance;

  Place({
    required this.name,
    required this.services,
    required this.link,
    required this.lat,
    required this.lng,
    required this.distance,
  });

  factory Place.fromFirestore(Map<String, dynamic> data, double userLat, double userLng) {
    try {
      final location = data['location'];
      if (location == null || location.length != 2) throw Exception("Ubicación inválida");

      final double lat = location[0];
      final double lng = location[1];
      final double distance = _calculateDistance(userLat, userLng, lat, lng);

      return Place(
        name: data['name'] ?? '',
        services: data['services'] ?? '',
        link: data['link'] ?? '',
        lat: lat,
        lng: lng,
        distance: distance,
      );
    } catch (e) {
      throw Exception('Error parsing Place: $e');
    }
  }

  static double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const p = 0.017453292519943295;
    final a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000; // En metros
  }
}