import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiriskapp/models/place.dart';

class nearCordobaScreen extends StatefulWidget {
  const nearCordobaScreen({super.key});

  @override
  State<nearCordobaScreen> createState() => _nearCordobaScreenState();
}

class _nearCordobaScreenState extends State<nearCordobaScreen> {
  late Future<Position> _userPosition;
  List<String> categories = ['Campings', 'beaches', 'Parks and Forests'];
  String selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _userPosition = Geolocator.getCurrentPosition();
  }

  Future<List<Place>> _loadPlaces(String category, Position pos) async {
    final snapshot = await FirebaseFirestore.instance.collection(category).get();

    final places = snapshot.docs.map((doc) {
      final data = doc.data();
      return Place.fromFirestore(data, pos.latitude, pos.longitude);
    }).toList();

    places.sort((a, b) => a.distance.compareTo(b.distance));

    return places;
  }

  Widget _buildCategorySection(String category, Position pos) {
    return FutureBuilder<List<Place>>(
      future: _loadPlaces(category, pos),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final places = snapshot.data!;
        if (places.isEmpty) return const SizedBox();

        return ExpansionTile(
          title: Text(category.toUpperCase()),
          children: places.map((place) {
            return ListTile(
              title: Text(place.name),
              subtitle: Text(
                "${place.services}\nA ${place.distance.toStringAsFixed(0)} m",
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.link),
                onPressed: () async {
                  final uri = Uri.parse(place.link);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Near Me'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All'),
              ),
              ...categories.map((c) => PopupMenuItem(
                    value: c,
                    child: Text(c),
                  )),
            ],
          ),
        ],
      ),
      body: FutureBuilder<Position>(
        future: _userPosition,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final position = snapshot.data!;
          final catToShow = selectedCategory == 'all' ? categories : [selectedCategory];

          return ListView(
            children: catToShow.map((cat) => _buildCategorySection(cat, position)).toList(),
          );
        },
      ),
    );
  }
}