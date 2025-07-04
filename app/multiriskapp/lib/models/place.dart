import 'dart:math';

class Place {
  final String name;
  final String services;
  final String link;
  final String lat;
  final String lng;
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
      final location = data['location'] ?? [0,0];
      final lat = location[0].toDouble();
      final lng = location[1].toDouble();
      final distance = _calculateDistance(userLat, userLng, lat, lng);

      return Place(
        name: data['name'] ?? '', 
        services: data['services'] ?? '', 
        link: data['link'] ?? '', 
        lat: lat, 
        lng: lng, 
        distance: distance,
      );
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  static double _calculateDistance(double lat1, double lat2, double lng1, double lng2) {
    const p = 0.017453292519943295;
    final a = 0.5 - (cos((lat2 - lat1) * p)/2) + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}