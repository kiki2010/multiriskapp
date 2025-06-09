import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Floodscreen extends StatefulWidget {
  final Position position;
  Floodscreen({Key? key, required this.position}) : super(key: key);

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
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
          Text("Lat: ${widget.position.latitude}, Lng: ${widget.position.longitude}"),
        ],
      ),
    );
  }
}