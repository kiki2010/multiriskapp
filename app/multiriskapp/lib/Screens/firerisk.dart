import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class FireScreen extends StatefulWidget {
  final Position position;

  FireScreen({Key? key, required this.position}) : super(key: key);

  @override
  State<FireScreen> createState() => _FireScreenState();
}

class _FireScreenState extends State<FireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fire Risk Screen")),
      body: Column(
        children: [
          Text("Lat: ${widget.position.latitude}, Lng: ${widget.position.longitude}"),
        ],
      ),
    );
  }
}
