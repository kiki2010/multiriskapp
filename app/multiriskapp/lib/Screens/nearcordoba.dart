import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class nearCordobaScreen extends StatefulWidget {
  const nearCordobaScreen({super.key});

  @override
  State<nearCordobaScreen> createState() => _nearCordobaScreenState();
}

class _nearCordobaScreenState extends State<nearCordobaScreen> {
  String selectedCategory = 'selectacategory';
  Position? currentPosition;

  final Map<String, IconData> categoryIcons = {
    'Campings': Icons.backpack,
    'ForestandParks': Icons.forest,
    'Beach': Icons.beach_access,
  };

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
    });
  }

  Stream<QuerySnapshot> _categoryStream() {
    return FirebaseFirestore.instance
      .collection(selectedCategory)
      .snapshots();
  }

  double _calculateDistance(List<dynamic> location) {
    if (currentPosition == null || location.length != 2) return 0;
    final lat = double.tryParse(location[0]) ?? 0;
    final lng = double.tryParse(location[1]) ?? 0;
    return Geolocator.distanceBetween(
      currentPosition!.latitude, currentPosition!.longitude, lat, lng
    ) / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Places Near Cordoba"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          const Divider(),
          DropdownButton(
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
            items: categoryIcons.keys.map((category) {
              return DropdownMenuItem(
                value:  category,
                child: Text(category),
              );
            }).toList(),
          ),
          const Divider(),
          if (selectedCategory == 'all' || selectedCategory == 'ForestandParks') ...[
            const Text("Forest and Parks"),
            const Divider(),
          ],
          if (selectedCategory == 'all' || selectedCategory == 'Beach') ...[
            const Text("Beaches"),
            const Divider(),
          ],
          if (selectedCategory == 'all' || selectedCategory == 'Campings') ...[
            const Text("Campings"),
            const Divider(),
          ],
          ],
        ),
      ),
    );
  }
}