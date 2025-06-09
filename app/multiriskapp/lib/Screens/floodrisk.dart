import 'package:flutter/material.dart';
import 'package:multiriskapp/main.dart';
import 'package:geolocator/geolocator.dart';

class Floodscreen extends StatefulWidget {
  const Floodscreen({super.key});

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  Position? posicion;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flood Risk Screen"),),
      body: Column(
        children: [
          Text('Flood Risk'),
        ],
      ),
    );
  }
}